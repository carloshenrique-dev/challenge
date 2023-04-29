import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/utils/enums.dart';
import 'package:challenge/modules/entity/cubit/entity_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../core/services/dependency_injection.dart';
import 'widgets/error_entity_widget.dart';
import 'widgets/success_entity_widget.dart';

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
  void initState() {
    _entityModel = _entityModel.copyWith(id: widget.entity.id);
    super.initState();
  }

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
        create: (context) => locator<EntityCubit>(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<EntityCubit, EntityState>(
              listener: (context, state) {
                if (state.status == Status.completed) {
                  Future.delayed(const Duration(seconds: 2), () {
                    context.pop(true);
                  });
                }
              },
              child: BlocBuilder<EntityCubit, EntityState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == Status.error) {
                    return ErrorEntityWidget(
                      message: state.errorMessage,
                      onButtonPressed: () =>
                          context.read<EntityCubit>().reset(),
                    );
                  } else if (state.status == Status.completed) {
                    return const SuccessEntityWidget();
                  }
                  return Column(
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
                                    active: (value == false || value == null)
                                        ? 1
                                        : 0);
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
                        child: BlocBuilder<EntityCubit, EntityState>(
                          builder: (context, state) {
                            return TextButton(
                              style: TextButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Theme.of(context).primaryColor,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  if (widget.entity.id != null) {
                                    await context
                                        .read<EntityCubit>()
                                        .updateHouseRules(_entityModel);
                                  } else {
                                    await context
                                        .read<EntityCubit>()
                                        .addHouseRules(_entityModel);
                                  }
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
                  );
                },
              ),
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
