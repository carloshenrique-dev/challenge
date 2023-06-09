import 'package:http/http.dart';

abstract class HttpService {
  Future<Response> get(int page);
  Future<Response> put(Object body, int id);
  Future<Response> post(Object body);
  Future<Response> delete(int id);
}
