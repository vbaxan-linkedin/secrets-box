import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/domain/use_cases/create_user.dart';
import 'package:secrets_box/src/core/domain/use_case/generate_uuid.dart';
import 'package:secrets_box/src/auth/domain/use_cases/get_has_users.dart';
import 'package:secrets_box/src/core/domain/use_case/hash_string.dart';
import 'package:secrets_box/src/core/domain/use_case/get_now_date_time.dart';

final class GetHasUsersMock extends Mock implements GetHasUsers {}

final class CreateUserMock extends Mock implements CreateUser {}

final class HashStringMock extends Mock implements HashString {}

final class GenerateUuidMock extends Mock implements GenerateUuid {}

final class GetNowDateTimeMock extends Mock implements GetNowDateTime {}