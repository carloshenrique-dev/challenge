import 'package:http/http.dart';

abstract class HttpService {
  Future<Response> get();
  Future<Response> put(Object body, String id);
  Future<Response> post(Object body);
  Future<Response> delete(String id);
}
