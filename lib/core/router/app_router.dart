import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/home/screens/home_screen.dart';

/// Centralized router configuration with shared navigator key.
class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: HomeRoute.path,
    routes: <GoRoute>[HomeRoute.route],
  );
}

/// Route definitions for the home module.
class HomeRoute {
  HomeRoute._();

  static const String path = '/';

  static final GoRoute route = GoRoute(
    path: path,
    name: 'home',
    builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
  );
}
