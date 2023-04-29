import 'package:challenge/core/models/data_model.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Data model tests', () {
    test('Data.fromJson returns a valid instance', () {
      final json = {
        'entities': [
          {
            'id': 1,
            'name': 'John',
          },
          {
            'id': 2,
            'name': 'Jane',
          }
        ],
        'pagination': {
          'current_page': 1,
          'per_page': 10,
          'total': 20,
        }
      };

      final data = Data.fromJson(json);

      expect(data.entities, isNotNull);
      expect(data.entities!.length, equals(2));
      expect(data.entities![0].id, equals(1));
      expect(data.entities![0].name, equals('John'));
      expect(data.entities![1].id, equals(2));
      expect(data.entities![1].name, equals('Jane'));

      expect(data.pagination, isNotNull);
      expect(data.pagination!.currentPage, equals(1));
      expect(data.pagination!.perPage, equals(10));
      expect(data.pagination!.total, equals(20));
    });

    test(
        'Data.fromJson returns an instance with null entities and pagination when input json is null',
        () {
      final data = Data.fromJson({});

      expect(data.entities, isNull);
      expect(data.pagination, isNull);
    });

    test(
        'Data.fromJson returns an instance with null entities and pagination when entities are null',
        () {
      final json = {
        'entities': null,
        'pagination': null,
      };

      final data = Data.fromJson(json);

      expect(data.entities, isNull);
      expect(data.pagination, isNull);
    });

    test('Data.toJson returns a valid json', () {
      final entity1 = Entities(id: 1, name: 'John');
      final entity2 = Entities(id: 2, name: 'Jane');
      final data = Data(entities: [entity1, entity2], pagination: null);

      final json = data.toJson();

      expect(json['entities'], isNotNull);
      expect(data.entities!.length, equals(2));
      expect(data.entities![1].id, equals(2));
      expect(data.entities![1].name, equals('Jane'));
      expect(data.entities![1].id, equals(2));
      expect(data.entities![1].name, equals('Jane'));
    });
  });
}
