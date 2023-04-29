import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/core/repositories/house_rules_repository_impl.dart';
import 'package:http/http.dart' as http;
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/models/house_rules_model.dart';
import 'package:challenge/core/services/http_service.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  group('HouseRulesRepositoryImpl tests', () {
    late HouseRulesRepositoryImpl repository;
    late MockHttpService mockHttpService;

    setUp(() {
      mockHttpService = MockHttpService();
      repository = HouseRulesRepositoryImpl(httpService: mockHttpService);
    });

    test('getHouseRules returns HouseRulesModel', () async {
      final fakeResponse = http.Response(
        json.encode({
          "success": true,
          "data": {
            "entities": [
              {"id": 585, "name": "Ch Test", "active": 0, "order": 0},
            ],
            "pagination": {
              "total": 18,
              "count": 10,
              "per_page": 10,
              "current_page": 1,
              "total_pages": 2,
              "links": {
                "next":
                    "http://sys-dev.searchandstay.com/api/admin/house_rules?page=2",
                "prev": null
              }
            }
          },
          "message": "Entities retrieved successfully."
        }),
        200,
      );
      when(() => mockHttpService.get(1)).thenAnswer((_) async => fakeResponse);

      final houseRules = await repository.getHouseRules(1);

      expect(houseRules, isA<HouseRulesModel>());
      expect(houseRules!.data!.entities!.length, equals(1));
      expect(houseRules.data!.entities![0].id, equals(585));
      expect(houseRules.data!.entities![0].name, equals('Ch Test'));
    });

    test('getHouseRules returns null on error', () async {
      when(() => mockHttpService.get(1)).thenThrow(Exception('Test error'));

      final houseRules = await repository.getHouseRules(1);

      expect(houseRules, isNull);
    });

    test('addHouseRules returns true on success', () async {
      final fakeEntity = Entities(id: 1, name: 'Test');
      final fakeResponse = http.Response('', 200);
      when(() => mockHttpService.post(json.encode(fakeEntity.toJson())))
          .thenAnswer((_) async => fakeResponse);

      final success = await repository.addHouseRules(fakeEntity);

      expect(success, isTrue);
    });

    test('addHouseRules returns false on error', () async {
      final fakeEntity = Entities(id: 1, name: 'Test');
      when(() => mockHttpService.post(json.encode(fakeEntity.toJson())))
          .thenThrow(Exception('Test error'));

      final success = await repository.addHouseRules(fakeEntity);

      expect(success, isFalse);
    });

    test('deleteHouseRules returns true on success', () async {
      final fakeResponse = http.Response('', 200);
      when(() => mockHttpService.delete(1))
          .thenAnswer((_) async => fakeResponse);

      final success = await repository.deleteHouseRules(1);

      expect(success, isTrue);
    });

    test('deleteHouseRules returns false on error', () async {
      when(() => mockHttpService.delete(1)).thenThrow(Exception('Test error'));

      final success = await repository.deleteHouseRules(1);

      expect(success, isFalse);
    });

    test('putHouseRules returns true on success', () async {
      final fakeEntity = Entities(id: 1, name: 'Test');
      final fakeResponse = http.Response('', 200);
      when(() => mockHttpService.put(
              json.encode(fakeEntity.toJson()), fakeEntity.id!))
          .thenAnswer((_) async => fakeResponse);

      final success = await repository.putHouseRules(fakeEntity);

      expect(success, isTrue);
    });

    test('putHouseRules returns false if id is null', () async {
      final fakeEntity = Entities(id: null, name: 'Test');

      final success = await repository.putHouseRules(fakeEntity);

      expect(success, isFalse);
    });

    test('putHouseRules returns false on error', () async {
      final fakeEntity = Entities(id: 1, name: 'Test');
      when(() => mockHttpService.put(
              json.encode(fakeEntity.toJson()), fakeEntity.id!))
          .thenThrow(Exception('Test error'));

      final success = await repository.putHouseRules(fakeEntity);

      expect(success, isFalse);
    });
  });
}
