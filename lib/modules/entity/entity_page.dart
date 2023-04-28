import 'package:flutter/material.dart';
import 'package:github_challenge/core/models/entities_model.dart';

class EntityPage extends StatelessWidget {
  final Entities entity;
  const EntityPage({
    super.key,
    required this.entity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Saved repositories',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            child: Text(entity.name ?? ' '),
          ),
        ),
      ),
    );
  }
}
