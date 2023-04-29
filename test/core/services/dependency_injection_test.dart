import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:challenge/core/repositories/house_rules_repository.dart';
import 'package:challenge/core/repositories/house_rules_repository_impl.dart';
import 'package:challenge/core/services/http_service.dart';
import 'package:challenge/core/services/http_service_impl.dart';

import 'package:challenge/modules/home/cubit/home_cubit.dart';
import 'package:challenge/modules/login/cubit/login_cubit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    GetIt.I.registerLazySingleton<HttpService>(() => HttpServiceImpl());
    GetIt.I.registerLazySingleton<HouseRulesRepository>(() =>
        HouseRulesRepositoryImpl(httpService: GetIt.I.get<HttpService>()));
    GetIt.I.registerFactory<HomeCubit>(() =>
        HomeCubit(houseRulesRepository: GetIt.I.get<HouseRulesRepository>()));
    GetIt.I.registerFactory<GoogleSignIn>(() => GoogleSignIn(scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ]));
    GetIt.I.registerFactory<LoginCubit>(() => LoginCubit());
  });
  group('Dependency Injection', () {
    setUp(() {
      GetIt.instance.reset();
    });

    test('Registers UserRepository as singleton', () {
      final repository1 = GetIt.I.get<HouseRulesRepository>();
      final repository2 = GetIt.I.get<HouseRulesRepository>();
      expect(repository1, equals(repository2));
    });

    test('Registers HomeCubit as factory', () {
      final cubit1 = GetIt.I.get<HomeCubit>();
      final cubit2 = GetIt.I.get<HomeCubit>();
      expect(cubit1, isNot(equals(cubit2)));
    });

    test('Registers GoogleSignIn as factory', () {
      final signIn1 = GetIt.I.get<GoogleSignIn>();
      final signIn2 = GetIt.I.get<GoogleSignIn>();
      expect(signIn1, isNot(equals(signIn2)));
    });

    test('Registers LoginCubit as factory', () {
      final cubit1 = GetIt.I.get<LoginCubit>();
      final cubit2 = GetIt.I.get<LoginCubit>();
      expect(cubit1, isNot(equals(cubit2)));
    });
  });
}
