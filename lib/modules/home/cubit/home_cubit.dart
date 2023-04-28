import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_challenge/core/models/entities_model.dart';
import 'package:github_challenge/core/models/user_data.dart';
import 'package:github_challenge/core/utils/enums.dart';

import '../../../core/repositories/house_rules_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HouseRulesRepository _houseRulesRepository;

  HomeCubit({
    required HouseRulesRepository houseRulesRepository,
  })  : _houseRulesRepository = houseRulesRepository,
        super(HomeState.initial());

  Future<void> getHouseRules() async {
    try {
      emit(state.copyWith(entitiesList: [], status: Status.loading));

      final houseRulesModel = await _houseRulesRepository.getHouseRules();

      if (houseRulesModel != null) {
        if (houseRulesModel.data?.entities != null) {
          if (houseRulesModel.data!.entities!.isNotEmpty) {
            emit(state.copyWith(
              entitiesList: houseRulesModel.data!.entities!,
              status: Status.completed,
            ));
          }
        }
      } else {
        emit(state.copyWith(entitiesList: [], status: Status.completed));
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  Future<void> addHouseRules() async {
    try {
      emit(state.copyWith(entitiesList: [], status: Status.loading));

      final houseRulesModel = await _houseRulesRepository.getHouseRules();

      if (houseRulesModel != null) {
        if (houseRulesModel.data?.entities != null) {
          if (houseRulesModel.data!.entities!.isNotEmpty) {
            emit(state.copyWith(
              entitiesList: houseRulesModel.data!.entities!,
              status: Status.completed,
            ));
          }
        }
      } else {
        emit(state.copyWith(entitiesList: [], status: Status.completed));
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

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  UserData getUser() {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return UserData(
          name: user.displayName!,
          avatarUrl: user.photoURL!,
          login: user.email,
        );
      }
      return UserData();
    } catch (e) {
      log(e.toString());
      return UserData();
    }
  }
}
