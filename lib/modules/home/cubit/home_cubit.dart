import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:challenge/core/models/entities_model.dart';
import 'package:challenge/core/models/user_data.dart';
import 'package:challenge/core/utils/enums.dart';

import '../../../core/repositories/house_rules_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HouseRulesRepository _houseRulesRepository;

  HomeCubit({
    required HouseRulesRepository houseRulesRepository,
  })  : _houseRulesRepository = houseRulesRepository,
        super(HomeState.initial());

  void init() {
    state.scrollController.addListener(detectScrolledToEnd);
  }

  void detectScrolledToEnd() async {
    if (state.scrollController.position.maxScrollExtent ==
        state.scrollController.offset) {
      await getHouseRules();
    }
  }

  Future<void> getHouseRules() async {
    try {
      if (state.status == Status.initial || state.page != state.totalPages) {
        emit(state.copyWith(status: Status.loading));

        final houseRulesModel = await _houseRulesRepository.getHouseRules(
            state.page == state.totalPages ? state.page : state.totalPages);

        if (houseRulesModel != null) {
          if (houseRulesModel.data?.pagination?.currentPage != null &&
              houseRulesModel.data?.pagination?.totalPages != null) {
            emit(state.copyWith(
              totalPages: houseRulesModel.data?.pagination?.totalPages,
              page: houseRulesModel.data?.pagination?.currentPage,
            ));
          }

          if (houseRulesModel.data?.entities != null) {
            if (houseRulesModel.data!.entities!.isNotEmpty) {
              emit(state.copyWith(
                entitiesList:
                    houseRulesModel.data!.entities! + state.entitiesList,
                status: Status.completed,
              ));
            }
          }
        } else {
          emit(state.copyWith(entitiesList: [], status: Status.completed));
        }
      }
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(errorMessage: e.toString(), status: Status.error));
    }
  }

  Future<void> deleteHouseRules(Entities entity) async {
    try {
      if (entity.id != null) {
        emit(state.copyWith(status: Status.loading));

        final isDeleted =
            await _houseRulesRepository.deleteHouseRules(entity.id!);

        if (isDeleted) {
          await getHouseRules();
        } else {
          emit(state.copyWith(
              errorMessage: 'Error to delete the house rule, try again',
              status: Status.error));
        }
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
        entitiesList: [],
        page: 1,
        totalPages: 1,
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
