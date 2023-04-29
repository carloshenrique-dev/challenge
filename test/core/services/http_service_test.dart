import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

abstract class HttpService {
  Future<http.Response> get(int page);
  Future<http.Response> put(Object body, int id);
  Future<http.Response> post(Object body);
  Future<http.Response> delete(int id);
}

class MockService implements HttpService {
  @override
  Future<http.Response> get(int page) async {
    return http.Response(jsonEncode({'page': page}), 200);
  }

  @override
  Future<http.Response> put(Object body, int id) async {
    return http.Response('Put request sent with body: $body, and id: $id', 200);
  }

  @override
  Future<http.Response> post(Object body) async {
    return http.Response('Post request sent with body: $body', 200);
  }

  @override
  Future<http.Response> delete(int id) async {
    return http.Response('Delete request sent with id: $id', 200);
  }
}

void main() {
  late MockService mockService;

  setUp(() {
    mockService = MockService();
  });

  group('HttpService', () {
    test('get should return a response with page data', () async {
      final response = await mockService.get(1);

      expect(response.statusCode, 200);
      expect(jsonDecode(response.body)['page'], 1);
    });

    test('put should return a response with body and id data', () async {
      final response = await mockService.put({'name': 'Test'}, 1);

      expect(response.statusCode, 200);
      expect(
          response.body, 'Put request sent with body: {name: Test}, and id: 1');
    });

    test('post should return a response with body data', () async {
      final response = await mockService.post({'name': 'Test'});

      expect(response.statusCode, 200);
      expect(response.body, 'Post request sent with body: {name: Test}');
    });

    test('delete should return a response with id data', () async {
      final response = await mockService.delete(1);

      expect(response.statusCode, 200);
      expect(response.body, 'Delete request sent with id: 1');
    });
  });
}
