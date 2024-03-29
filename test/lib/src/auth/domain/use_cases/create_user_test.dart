import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/domain/repositories/auth_repository.dart';
import 'package:secrets_box/src/auth/domain/use_cases/create_user.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import '../../argument_keys.dart';
import 'mocks.dart';

late final AuthRepository _repo;
late final CreateUser _createUser;

void main() {
  setUpAll(() {
    _repo = AuthRepositoryMock();
    _createUser = CreateUser(_repo);
  });

  setUp(() {
    reset(_repo);
  });

  tearDown(resetMocktailState);

  const CreateUserParams params = CreateUserParams.empty();

  test(
    'should call the [AuthRepository.createUser]',
    () async {
      const RightResult<int> expectedResult = RightResult<int>(1717);

      when(() {
        return _repo.createUser(
          uuId: any(named: uuIdKey),
          username: any(named: usernameKey),
          passwordHash: any(named: passwordHashKey),
          salt: any(named: saltKey),
        );
      }).thenAnswer((_) async => expectedResult);

      final EitherResult<void> result = await _createUser(params);

      expect(result, expectedResult);

      final VerificationResult verificationResult = verify(() {
        return _repo.createUser(
          uuId: captureAny(named: uuIdKey),
          username: captureAny(named: usernameKey),
          passwordHash: captureAny(named: passwordHashKey),
          salt: captureAny(named: saltKey),
        );
      });
      expect(verificationResult.callCount, 1);
      expect(verificationResult.captured, params.props);

      verifyNoMoreInteractions(_repo);
    },
  );
}
