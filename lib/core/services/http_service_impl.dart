import 'package:http/http.dart' as http;

import './http_service.dart';

class HttpServiceImpl implements HttpService {
  final Uri _baseUrl =
      Uri.parse('https://sys-dev.searchandstay.com/api/admin/house_rules');
  final String _token =
      'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8';

  @override
  Future<http.Response> get() async {
    try {
      return await http.get(
        _baseUrl,
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<http.Response> delete(String id) async {
    try {
      return await http.delete(
        _baseUrl,
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<http.Response> post(Object body) async {
    try {
      return await http.post(
        _baseUrl,
        body: body,
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<http.Response> put(Object body, String id) async {
    try {
      return await http.put(
        _baseUrl,
        body: body,
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
