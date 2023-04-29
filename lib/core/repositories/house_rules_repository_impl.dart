import 'dart:convert';
import 'dart:developer';

import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/models/house_rules_model.dart';
import 'package:challenge/core/services/http_service.dart';

import './house_rules_repository.dart';

class HouseRulesRepositoryImpl implements HouseRulesRepository {
  final HttpService _httpService;

  HouseRulesRepositoryImpl({
    required HttpService httpService,
  }) : _httpService = httpService;

  @override
  Future<HouseRulesModel?> getHouseRules(int page) async {
    try {
      final response = await _httpService.get(page);
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        return HouseRulesModel.fromJson(data);
      }
      return null;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<bool> addHouseRules(Entities entity) async {
    try {
      final response = await _httpService.post(json.encode(entity.toJson()));
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> deleteHouseRules(int id) async {
    try {
      final response = await _httpService.delete(id);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<bool> putHouseRules(Entities entity) async {
    try {
      if (entity.id != null) {
        final response =
            await _httpService.put(json.encode(entity.toJson()), entity.id!);
        if (response.statusCode == 200) {
          return true;
        }
      }

      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
