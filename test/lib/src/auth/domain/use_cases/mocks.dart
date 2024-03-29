import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/domain/repositories/auth_repository.dart';
import 'package:secrets_box/src/core/domain/use_case/app_hash.dart';
import 'package:secrets_box/src/core/domain/use_case/app_utf8_codec.dart';
import 'package:secrets_box/src/core/domain/use_case/app_uuid.dart';

final class AuthRepositoryMock extends Mock implements AuthRepository {}

final class AppUtf8CodecMock extends Mock implements AppUtf8Codec {}

final class AppHashMock extends Mock implements AppHash {}

final class AppUuidMock extends Mock implements AppUuid {}