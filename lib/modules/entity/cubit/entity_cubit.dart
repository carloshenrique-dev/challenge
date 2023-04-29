import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/utils/enums.dart';

import '../../../core/repositories/house_rules_repository.dart';

part 'entity_state.dart';

class EntityCubit extends Cubit<EntityState> {
  final HouseRulesRepository _houseRulesRepository;

  EntityCubit({
    required HouseRulesRepository houseRulesRepository,
  })  : _houseRulesRepository = houseRulesRepository,
        super(const EntityState.initial());

  Future<void> updateHouseRules(Entities entity) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final isUpdated = await _houseRulesRepository.putHouseRules(entity);

      if (isUpdated) {
        emit(state.copyWith(status: Status.completed));
      } else {
        emit(state.copyWith(
            status: Status.error,
            errorMessage: 'Failed to connect to the server'));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  Future<void> addHouseRules(Entities entity) async {
    try {
      emit(state.copyWith(status: Status.loading));

      final isUpdated = await _houseRulesRepository.addHouseRules(entity);

      if (isUpdated) {
        emit(state.copyWith(status: Status.completed));
      } else {
        emit(state.copyWith(
            status: Status.error,
            errorMessage: 'Failed to connect to the server'));
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
