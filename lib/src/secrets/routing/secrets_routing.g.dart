// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secrets_routing.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $secretsScreenRoute,
    ];

RouteBase get $secretsScreenRoute => GoRouteData.$route(
      path: '/secrets',
      factory: $SecretsScreenRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'createOrUpdateSecret',
          factory: $CreateOrUpdateSecretRouteExtension._fromState,
        ),
      ],
    );

extension $SecretsScreenRouteExtension on SecretsScreenRoute {
  static SecretsScreenRoute _fromState(GoRouterState state) =>
      const SecretsScreenRoute();

  String get location => GoRouteData.$location(
        '/secrets',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $CreateOrUpdateSecretRouteExtension on CreateOrUpdateSecretRoute {
  static CreateOrUpdateSecretRoute _fromState(GoRouterState state) =>
      const CreateOrUpdateSecretRoute();

  String get location => GoRouteData.$location(
        '/secrets/createOrUpdateSecret',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
