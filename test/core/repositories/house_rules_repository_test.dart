import 'package:flutter_test/flutter_test.dart';
import 'package:challenge/core/models/data_model.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/models/house_rules_model.dart';
import 'package:challenge/core/repositories/house_rules_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHouseRulesRepository extends Mock implements HouseRulesRepository {}

void main() {
  late MockHouseRulesRepository mockHouseRulesRepository;
  late Entities entity;
  late HouseRulesModel houseRules;

  setUp(() {
    mockHouseRulesRepository = MockHouseRulesRepository();
    entity = Entities(id: 1, name: "Entity 1");
    houseRules = HouseRulesModel(
      success: true,
      data: Data(),
      message: "Description 1",
    );
  });

  test('getHouseRules should return HouseRulesModel', () async {
    when(() => mockHouseRulesRepository.getHouseRules(1))
        .thenAnswer((_) async => houseRules);

    final result = await mockHouseRulesRepository.getHouseRules(1);

    expect(result, isInstanceOf<HouseRulesModel>());
  });

  test('addHouseRules should return true', () async {
    when(() => mockHouseRulesRepository.addHouseRules(entity))
        .thenAnswer((_) async => true);

    final result = await mockHouseRulesRepository.addHouseRules(entity);

    expect(result, true);
  });

  test('deleteHouseRules should return true', () async {
    when(() => mockHouseRulesRepository.deleteHouseRules(1))
        .thenAnswer((_) async => true);

    final result = await mockHouseRulesRepository.deleteHouseRules(1);

    expect(result, true);
  });

  test('putHouseRules should return true', () async {
    when(() => mockHouseRulesRepository.putHouseRules(entity))
        .thenAnswer((_) async => true);

    final result = await mockHouseRulesRepository.putHouseRules(entity);

    expect(result, true);
  });
}
