import 'package:http/http.dart' as http;

import './http_service.dart';

class HttpServiceImpl implements HttpService {
  final String _baseUrl =
      'https://sys-dev.searchandstay.com/api/admin/house_rules';
  final String _token =
      'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8';

  @override
  Future<http.Response> get(int page) async {
    try {
      return await http.get(
        Uri.parse('$_baseUrl?page=$page'),
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<http.Response> delete(int id) async {
    try {
      return await http.delete(
        Uri.parse('$_baseUrl/$id'),
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
        Uri.parse(_baseUrl),
        body: body,
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  @override
  Future<http.Response> put(Object body, int id) async {
    try {
      return await http.put(
        Uri.parse('$_baseUrl/$id'),
        body: body,
        headers: {'Authorization': 'Bearer $_token'},
      );
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
