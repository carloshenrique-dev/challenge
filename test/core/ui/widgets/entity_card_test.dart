import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/ui/widgets/entity_card.dart';

void main() {
  group('EntityCard', () {
    final entities = Entities(
      id: 1,
      name: 'Test entity',
      active: 0,
    );

    testWidgets('should display entity name and active status', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: EntityCard(
              entities: entities,
              onDeletePressed: () {},
              onTap: () {},
            ),
          ),
        ),
      );

      final entityNameFinder = find.text('Test entity');
      expect(entityNameFinder, findsOneWidget);

      final entityStatusFinder = find.text('Active');
      expect(entityStatusFinder, findsOneWidget);
    });

    testWidgets('should display inactive status when active is not 0',
        (tester) async {
      final entities = Entities(
        id: 1,
        name: 'Test entity',
        active: 1,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: EntityCard(
              entities: entities,
              onDeletePressed: () {},
              onTap: () {},
            ),
          ),
        ),
      );

      final entityStatusFinder = find.text('Inactive');
      expect(entityStatusFinder, findsOneWidget);
    });

    testWidgets('should call onDeletePressed when delete button is pressed',
        (tester) async {
      var deletePressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: EntityCard(
              entities: entities,
              onDeletePressed: () {
                deletePressed = true;
              },
              onTap: () {},
            ),
          ),
        ),
      );

      final deleteButton = find.byIcon(Icons.close);
      await tester.tap(deleteButton);
      await tester.pump();

      expect(deletePressed, true);
    });

    testWidgets('should call onTap when the card is tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: EntityCard(
              entities: entities,
              onDeletePressed: () {},
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      final card = find.byType(InkWell).first;
      await tester.tap(card);
      await tester.pump();

      expect(tapped, true);
    });
  });
}
