import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:secrets_box/generated/l10n.dart';
import 'package:secrets_box/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:secrets_box/src/core/presentation/routing/app_routing.dart';
import 'package:secrets_box/src/core/services/di/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const SecretsBoxApp());
}

class SecretsBoxApp extends StatelessWidget {
  const SecretsBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => sl<AuthBloc>(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          S.delegate,
        ],
        routerConfig: goRouter,
      ),
    );
  }
}
