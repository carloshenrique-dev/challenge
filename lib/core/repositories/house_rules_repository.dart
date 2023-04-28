import '../models/house_rules_model.dart';

abstract class HouseRulesRepository {
  Future<HouseRulesModel?> getHouseRules();
  Future<bool> addHouseRules(HouseRulesModel houseRulesModel);
  Future<bool> deleteHouseRules(int id);
  Future<bool> putHouseRules(HouseRulesModel houseRulesModel, int id);
}
