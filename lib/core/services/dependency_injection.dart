import 'package:get_it/get_it.dart';
import 'package:github_challenge/core/repositories/house_rules_repository.dart';
import 'package:github_challenge/core/services/http_service.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:github_challenge/modules/home/cubit/home_cubit.dart';
import 'package:github_challenge/modules/login/cubit/login_cubit.dart';

import '../repositories/house_rules_repository_impl.dart';
import 'http_service_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //Http service  DI
  locator.registerLazySingleton<HttpService>(
    () => HttpServiceImpl(),
  );
  //HomeCubit DI
  locator.registerFactory<HomeCubit>(
    () => HomeCubit(
      houseRulesRepository: locator<HouseRulesRepository>(),
    ),
  );

  //Database Repository DI
  locator.registerLazySingleton<HouseRulesRepository>(
    () => HouseRulesRepositoryImpl(
      httpService: locator<HttpService>(),
    ),
  );

  //google sign in DI
  locator.registerFactory<GoogleSignIn>(
    () => GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    ),
  );
  //LoginCubit DI
  locator.registerFactory<LoginCubit>(
    () => LoginCubit(),
  );
}
