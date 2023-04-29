import 'package:challenge/core/models/data_model.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/models/house_rules_model.dart';
import 'package:challenge/core/models/links_model.dart';
import 'package:challenge/core/models/pagination_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HouseRulesModel', () {
    final data = Data(
      pagination: Pagination(
          total: 14,
          count: 10,
          perPage: 10,
          currentPage: 1,
          totalPages: 2,
          links: Links(
              next:
                  "http://sys-dev.searchandstay.com/api/admin/house_rules?page=2",
              prev: null)),
      entities: [Entities(id: 606, name: 'some new', active: 1, order: 0)],
    );

    test('fromJson() should populate all fields', () {
      // Arrange
      final json = {
        "success": true,
        "data": {
          "entities": [
            {"id": 606, "name": "some new", "active": 1, "order": 0}
          ],
          "pagination": {
            "total": 14,
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
        "message": "Success"
      };

      // Act
      final model = HouseRulesModel.fromJson(json);

      // Assert
      expect(model.success, equals(true));
      expect(
        model.data!.toJson(),
        equals(data.toJson()),
      );
      expect(model.message, equals('Success'));
    });

    test('toJson() should include data if it exists', () {
      // Arrange

      final model =
          HouseRulesModel(success: true, data: data, message: 'Success');

      // Act
      final json = model.toJson();

      // Assert
      expect(json.containsKey('data'), isTrue);
      expect(json['data'], equals(data.toJson()));
    });

    test('== should compare all fields', () {
      // Arrange

      final model1 =
          HouseRulesModel(success: true, data: data, message: 'Success');
      final model2 =
          HouseRulesModel(success: true, data: data, message: 'Success');

      // Act
      final result = model1 == model2;

      // Assert
      expect(result, isTrue);
    });

    test('hashCode should include all fields', () {
      // Arrange

      final model =
          HouseRulesModel(success: true, data: data, message: 'Success');

      // Act
      final hashcode = model.hashCode;

      // Assert
      expect(hashcode, isNotNull);
    });
  });
}
