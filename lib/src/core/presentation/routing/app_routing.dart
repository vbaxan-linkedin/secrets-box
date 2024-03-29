import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secrets_box/src/auth/presentation/views/index.dart';
import 'package:secrets_box/src/core/presentation/views/index.dart';
import 'package:secrets_box/src/secrets/routing/secrets_routing.dart';
import 'package:secrets_box/src/settings/presentation/views/index.dart';

part 'app_routing.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorSecretsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSecrets');
final GlobalKey<NavigatorState> _shellNavigatorSettingsKey = GlobalKey<NavigatorState>(debugLabel: 'shellSettings');

final GoRouter goRouter = GoRouter(
  initialLocation: '/auth',
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    $authScreenRoute,
    StatefulShellRoute.indexedStack(
      pageBuilder: (BuildContext context, GoRouterState state, StatefulNavigationShell shell) {
        return NoTransitionPage<void>(child: MainScreen(navigationShell: shell));
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSecretsKey,
          routes: <RouteBase>[$secretsScreenRoute],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorSettingsKey,
          routes: <RouteBase>[$settingsScreenRoute],
        )
      ],
    ),
  ],
);

@TypedGoRoute<AuthScreenRoute>(path: '/auth')
@immutable
final class AuthScreenRoute extends GoRouteData {
  const AuthScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthScreen();
  }
}

@TypedGoRoute<SettingsScreenRoute>(path: '/settings')
@immutable
final class SettingsScreenRoute extends GoRouteData {
  const SettingsScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}
