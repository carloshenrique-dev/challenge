import 'package:firebase_auth/firebase_auth.dart';
import 'package:github_challenge/core/models/entities_model.dart';
import 'package:github_challenge/modules/entity/entity_page.dart';
import 'package:go_router/go_router.dart';

import '../../modules/home/home_page.dart';
import '../../modules/login/login_page.dart';

enum AppRoutes { login, home, entity }

final GoRouter routes = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  restorationScopeId: 'router',
  routes: [
    GoRoute(
      path: '/home',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/entity',
      name: AppRoutes.entity.name,
      builder: (context, state) {
        final arguments = state.extra as Map<String, dynamic>;
        return EntityPage(
          entity: arguments['entity'] as Entities,
        );
      },
    ),
    GoRoute(
      path: '/',
      name: AppRoutes.login.name,
      builder: (context, state) => const LoginPage(),
    ),
  ],
  redirect: (context, state) {
    // if the user is not logged in, they need to login
    final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    final bool loggingIn = state.subloc == '/';
    if (!loggedIn) {
      return '/';
    }

    // if the user is logged in but still on the login page, send them to
    // the home page
    if (loggingIn) {
      return '/home';
    }

    // no need to redirect at all
    return null;
  },
);
