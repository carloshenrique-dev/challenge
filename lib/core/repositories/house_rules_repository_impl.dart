import 'dart:convert';
import 'dart:developer';

import 'package:github_challenge/core/models/house_rules_model.dart';
import 'package:github_challenge/core/services/http_service.dart';

import './house_rules_repository.dart';

class HouseRulesRepositoryImpl implements HouseRulesRepository {
  final HttpService _httpService;

  HouseRulesRepositoryImpl({
    required HttpService httpService,
  }) : _httpService = httpService;

  @override
  Future<HouseRulesModel?> getHouseRules() async {
    try {
      final response = await _httpService.get();
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
  Future<bool> addHouseRules(HouseRulesModel houseRulesModel) async {
    try {
      final response = await _httpService.post(houseRulesModel);
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
  Future<bool> putHouseRules(HouseRulesModel houseRulesModel, int id) async {
    try {
      final response = await _httpService.put(houseRulesModel, id);
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
