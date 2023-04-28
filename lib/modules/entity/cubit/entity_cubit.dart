import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/utils/enums.dart';

import '../../../core/repositories/house_rules_repository.dart';

part 'entity_state.dart';

class EntityCubit extends Cubit<EntityState> {
  final HouseRulesRepository _houseRulesRepository;

  EntityCubit({
    required HouseRulesRepository houseRulesRepository,
  })  : _houseRulesRepository = houseRulesRepository,
        super(const EntityState.initial());

  Future<void> addHouseRules() async {
    try {
      emit(state.copyWith(status: Status.loading));

      final houseRulesModel = await _houseRulesRepository.getHouseRules();

      if (houseRulesModel != null) {
        if (houseRulesModel.data?.entities != null) {
          if (houseRulesModel.data!.entities!.isNotEmpty) {
            emit(state.copyWith(
              status: Status.completed,
            ));
          }
        }
      } else {
        emit(state.copyWith(status: Status.completed));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  void reset() {
    emit(
      state.copyWith(
        status: Status.initial,
        errorMessage: '',
      ),
    );
  }
}
