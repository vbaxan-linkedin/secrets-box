library auth_views;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secrets_box/generated/l10n.dart';
import 'package:secrets_box/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:secrets_box/src/auth/presentation/bloc/events/index.dart';
import 'package:secrets_box/src/auth/presentation/bloc/states/index.dart';
import 'package:secrets_box/src/core/presentation/extensions.dart';
import 'package:secrets_box/src/core/presentation/views/index.dart';
import 'package:secrets_box/src/secrets/routing/secrets_routing.dart';

part 'auth_screen.dart';
part 'create_profile_screen.dart';
part 'login_screen.dart';