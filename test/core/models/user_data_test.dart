import 'package:challenge/core/models/user_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('toJson', () {
    test('should return a JSON string', () {
      // arrange
      final userData = UserData(
        login: 'johndoe',
        id: 1234,
        nodeId: 'abcd1234',
        // set other properties
      );

      // act
      final jsonStr = userData.toJson();

      // assert
      expect(jsonStr, isA<String>());
      expect(() => UserData.fromJson(jsonStr), returnsNormally);
    });

    test('fromJson should return a UserData object', () {
      // arrange
      const jsonStr = '{"login": "johndoe", "id": 1234, "nodeId": "abcd1234"}';

      // act
      final userData = UserData.fromJson(jsonStr);

      // assert
      expect(userData, isA<UserData>());
      expect(userData.login, equals('johndoe'));
      expect(userData.id, equals(1234));
      expect(userData.nodeId, equals('abcd1234'));
    });
  });
}
