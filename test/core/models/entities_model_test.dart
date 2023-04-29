import 'package:challenge/core/models/entities_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Entities', () {
    test('should create an Entities object from a JSON map', () {
      final json = {'id': 1, 'name': 'Test Entity', 'active': 1, 'order': 2};

      final entities = Entities.fromJson(json);

      expect(entities.id, 1);
      expect(entities.name, 'Test Entity');
      expect(entities.active, 1);
      expect(entities.order, 2);
    });

    test('should create a JSON map from an Entities object', () {
      final entities =
          Entities(id: 1, name: 'Test Entity', active: 1, order: 2);

      final json = entities.toJson();

      expect(json['house_rules']['name'], 'Test Entity');
      expect(json['house_rules']['active'], 1);
    });

    test('should create a copy of an Entities object with updated values', () {
      final entities =
          Entities(id: 1, name: 'Test Entity', active: 1, order: 2);

      final updatedEntities = entities.copyWith(name: 'New Name', active: 0);

      expect(updatedEntities.id, 1);
      expect(updatedEntities.name, 'New Name');
      expect(updatedEntities.active, 0);
      expect(updatedEntities.order, 2);
    });

    test('should return a string representation of the Entities object', () {
      final entities =
          Entities(id: 1, name: 'Test Entity', active: 1, order: 2);

      final entitiesString = entities.toString();

      expect(entitiesString,
          'Entities(id: 1, name: Test Entity, active: 1, order: 2)');
    });
  });
}
