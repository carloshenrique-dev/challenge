import 'package:challenge/core/models/links_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Links', () {
    test('fromJson() should populate all fields', () {
      // Arrange
      final json = {
        'next': 'https://example.com/next',
        'prev': 'https://example.com/prev'
      };

      // Act
      final links = Links.fromJson(json);

      // Assert
      expect(links.next, equals('https://example.com/next'));
      expect(links.prev, equals('https://example.com/prev'));
    });

    test('toJson() should include all fields', () {
      // Arrange
      final links = Links(
          next: 'https://example.com/next', prev: 'https://example.com/prev');

      // Act
      final json = links.toJson();

      // Assert
      expect(json.containsKey('next'), isTrue);
      expect(json['next'], equals('https://example.com/next'));
      expect(json.containsKey('prev'), isTrue);
      expect(json['prev'], equals('https://example.com/prev'));
    });

    test('fromJson() should handle missing fields', () {
      // Arrange
      final json = {'next': 'https://example.com/next'};

      // Act
      final links = Links.fromJson(json);

      // Assert
      expect(links.next, equals('https://example.com/next'));
      expect(links.prev, isNull);
    });

    test('toJson() should handle null fields', () {
      // Arrange
      final links = Links(next: 'https://example.com/next', prev: null);

      // Act
      final json = links.toJson();

      // Assert
      expect(json.containsKey('next'), isTrue);
      expect(json['next'], equals('https://example.com/next'));
      expect(json.containsKey('prev'), isTrue);
      expect(json['prev'], isNull);
    });
  });
}
