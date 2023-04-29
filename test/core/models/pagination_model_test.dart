import 'package:challenge/core/models/links_model.dart';
import 'package:challenge/core/models/pagination_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pagination', () {
    late Pagination pagination;

    setUp(() {
      pagination = Pagination(
        total: 10,
        count: 2,
        perPage: 5,
        currentPage: 1,
        totalPages: 2,
        links: Links(
          next: 'https://example.com/api?page=2',
          prev: 'https://example.com/api?page=2',
        ),
      );
    });

    test('fromJson creates a Pagination object correctly', () {
      final Map<String, dynamic> json = {
        'total': 10,
        'count': 2,
        'per_page': 5,
        'current_page': 1,
        'total_pages': 2,
        'links': {
          'next': 'https://example.com/api?page=2',
          'prev': 'https://example.com/api?page=2',
        },
      };

      final Pagination result = Pagination.fromJson(json);

      expect(result, pagination);
    });

    test('toJson creates a JSON object correctly', () {
      final Map<String, dynamic> expectedJson = {
        'total': 10,
        'count': 2,
        'per_page': 5,
        'current_page': 1,
        'total_pages': 2,
        'links': {
          'next': 'https://example.com/api?page=2',
          'prev': 'https://example.com/api?page=2',
        },
      };

      final Map<String, dynamic> resultJson = pagination.toJson();

      expect(resultJson, expectedJson);
    });

    test('equality', () {
      final Pagination samePagination = Pagination(
        total: 10,
        count: 2,
        perPage: 5,
        currentPage: 1,
        totalPages: 2,
        links: Links(
          next: 'https://example.com/api?page=2',
          prev: 'https://example.com/api?page=2',
        ),
      );

      final Pagination differentPagination = Pagination(
        total: 5,
        count: 1,
        perPage: 5,
        currentPage: 1,
        totalPages: 1,
        links: Links(
          next: 'https://example.com/api?page=2',
          prev: 'https://example.com/api?page=2',
        ),
      );

      expect(pagination, samePagination);
      expect(pagination == differentPagination, false);
    });
  });
}
