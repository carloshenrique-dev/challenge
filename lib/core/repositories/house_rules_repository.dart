import 'package:challenge/core/models/entities_model.dart';

import '../models/house_rules_model.dart';

abstract class HouseRulesRepository {
  Future<HouseRulesModel?> getHouseRules(int page);
  Future<bool> addHouseRules(Entities entity);
  Future<bool> deleteHouseRules(int id);
  Future<bool> putHouseRules(Entities entity);
}
