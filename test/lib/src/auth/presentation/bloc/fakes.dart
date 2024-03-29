import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/domain/use_cases/create_user.dart';
import 'package:secrets_box/src/core/domain/use_case/hash_string.dart';

final class HashStringParamsFake extends Fake implements HashStringParams {}

final class CreateUserParamsFake extends Fake implements CreateUserParams {}