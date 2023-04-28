import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/models/entities_model.dart';
import 'package:github_challenge/modules/home/cubit/home_cubit.dart';

import '../../core/services/dependency_injection.dart';

class EntityPage extends StatefulWidget {
  final Entities entity;

  const EntityPage({
    super.key,
    required this.entity,
  });

  @override
  State<EntityPage> createState() => _EntityPageState();
}

class _EntityPageState extends State<EntityPage> {
  final _formKey = GlobalKey<FormState>();
  var _entityModel = Entities();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.entity.name ?? 'Entity',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (context) => locator<HomeCubit>(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Entity Name'),
                      TextFormField(
                        initialValue: widget.entity.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _entityModel =
                              _entityModel.copyWith(name: value ?? '');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormField(
                        initialValue: widget.entity.active != null
                            ? isActive(widget.entity.active!)
                            : false,
                        onSaved: (value) {
                          _entityModel = _entityModel.copyWith(
                              active:
                                  (value == false || value == null) ? 1 : 0);
                        },
                        builder: (FormFieldState<bool> field) {
                          return SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Entity is active?'),
                            value: field.value ?? false,
                            onChanged: (val) {
                              field.didChange(val);
                              _entityModel = _entityModel.copyWith(
                                  active: (val == false) ? 1 : 0);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(),
                SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return TextButton(
                        style: TextButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(_entityModel);
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isActive(int active) {
    if (active == 0) {
      return true;
    } else {
      return false;
    }
  }
}
