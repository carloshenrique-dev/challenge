import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/core/services/http_service_impl.dart';

void main() {
  late HttpServiceImpl httpService;

  setUp(() {
    httpService = HttpServiceImpl();
  });

  group('HttpServiceImpl tests', () {
    test('get should return a valid response', () async {
      final response = await httpService.get(1);

      expect(response.statusCode, 200);
      expect(response.body, isNotEmpty);
    });

    test('delete should return a valid response', () async {
      final response = await httpService.delete(1);

      expect(response.statusCode, 404);
    });

    test('post should return a valid response', () async {
      final body = {'key': 'value'};
      final response = await httpService.post(body);

      expect(response.statusCode, 422);
      expect(response.body, isNotEmpty);
    });

    test('put should return a valid response', () async {
      final body = {'key': 'value'};
      final response = await httpService.put(body, 1);

      expect(response.statusCode, 404);
      expect(response.body, isNotEmpty);
    });

    test('invalid request should throw an exception', () async {
      try {
        await httpService.get(-1);
        fail("exception not thrown");
      } catch (e) {
        expect(e, isInstanceOf<TestFailure>());
      }
    });
  });
}
