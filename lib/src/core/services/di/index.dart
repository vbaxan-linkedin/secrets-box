library di;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';
import 'package:secrets_box/src/auth/data/datasources/index.dart';
import 'package:secrets_box/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:secrets_box/src/auth/domain/repositories/auth_repository.dart';
import 'package:secrets_box/src/auth/domain/use_cases/index.dart';
import 'package:secrets_box/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:secrets_box/src/auth/presentation/bloc/states/index.dart';
import 'package:secrets_box/src/core/domain/use_case/index.dart';
import 'package:secrets_box/src/core/presentation/extensions.dart';
import 'package:secrets_box/src/core/services/index.dart';
import 'package:secrets_box/src/secrets/data/datasources/index.dart';
import 'package:secrets_box/src/secrets/data/repositories/secrets_repository_impl.dart';
import 'package:secrets_box/src/secrets/domain/repository/secrets_repository.dart';
import 'package:secrets_box/src/secrets/domain/use_cases/index.dart';
import 'package:secrets_box/src/secrets/presentation/bloc/secrets_bloc.dart';

part 'auth_di.dart';
part 'core_di.dart';
part 'injection_container.dart';
part 'object_box_di.dart';
part 'secrets_di.dart';
