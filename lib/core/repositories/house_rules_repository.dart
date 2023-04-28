import '../models/house_rules_model.dart';

abstract class HouseRulesRepository {
  Future<HouseRulesModel?> getHouseRules();
}
