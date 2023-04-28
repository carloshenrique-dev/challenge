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
}
