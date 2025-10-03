import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/exchange/presentation/screens/exchange_screen.dart';

class AppRouter {
  AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: ExchangeRoute.path,
    routes: <GoRoute>[ExchangeRoute.route],
  );
}

class ExchangeRoute {
  ExchangeRoute._();

  static const String path = '/';

  static final GoRoute route = GoRoute(
    path: path,
    name: 'exchange',
    builder: (BuildContext context, GoRouterState state) => const ExchangeScreen(),
  );
}
