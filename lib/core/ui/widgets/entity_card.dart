import 'package:flutter/material.dart';
import 'package:challenge/core/models/entities_model.dart';

class EntityCard extends StatelessWidget {
  final Entities entities;
  final VoidCallback onDeletePressed;
  final VoidCallback onTap;

  const EntityCard({
    super.key,
    required this.entities,
    required this.onDeletePressed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
            title: Text(
              entities.name ?? 'No name',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            minVerticalPadding: 0,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 10,
            ),
            subtitle: Text(
              entities.active != null ? isActive(entities.active!) : 'Inactive',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
            ),
            trailing: IconButton(
              onPressed: onDeletePressed,
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            )),
      ),
    );
  }

  String isActive(int active) {
    if (active == 0) {
      return 'Active';
    } else {
      return 'Inactive';
    }
  }
}
