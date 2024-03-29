import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secrets_box/src/secrets/presentation/views/create_or_update/index.dart';
import 'package:secrets_box/src/secrets/presentation/views/index.dart';

part 'secrets_routing.g.dart';

@TypedGoRoute<SecretsScreenRoute>(
  path: '/secrets',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<CreateOrUpdateSecretRoute>(
      path: 'createOrUpdateSecret',
    ),
  ],
)
@immutable
final class SecretsScreenRoute extends GoRouteData {
  const SecretsScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SecretsScreen();
  }
}

@immutable
final class CreateOrUpdateSecretRoute extends GoRouteData {
  const CreateOrUpdateSecretRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage<CreateOrUpdateSecretRoute>(
      child: const CreateOrUpdateSecretScreen(),
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: animation.drive(
            Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.linear))
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 100),
    );
  }
}
