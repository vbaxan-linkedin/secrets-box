// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routing.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $authScreenRoute,
      $settingsScreenRoute,
    ];

RouteBase get $authScreenRoute => GoRouteData.$route(
      path: '/auth',
      factory: $AuthScreenRouteExtension._fromState,
    );

extension $AuthScreenRouteExtension on AuthScreenRoute {
  static AuthScreenRoute _fromState(GoRouterState state) =>
      const AuthScreenRoute();

  String get location => GoRouteData.$location(
        '/auth',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsScreenRoute => GoRouteData.$route(
      path: '/settings',
      factory: $SettingsScreenRouteExtension._fromState,
    );

extension $SettingsScreenRouteExtension on SettingsScreenRoute {
  static SettingsScreenRoute _fromState(GoRouterState state) =>
      const SettingsScreenRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
