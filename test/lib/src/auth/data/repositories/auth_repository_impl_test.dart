import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/data/datasources/auth_box_data_source.dart';
import 'package:secrets_box/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:secrets_box/src/auth/domain/repositories/auth_repository.dart';
import 'package:secrets_box/src/core/errors/exceptions.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import '../../../core/utils.dart';
import '../../argument_keys.dart';
import 'auth_box_data_source.mock.dart';

late final AuthBoxDataSource _dataSource;
late final AuthRepository _repository;

void main() {
  setUpAll(() {
    _dataSource = AuthBoxDataSourceMock();
    _repository = AuthRepositoryImpl(_dataSource);
  });

  setUp(() {
    reset(_dataSource);
  });

  tearDown(resetMocktailState);

  group('createUser', () {
    const String uuId = 'uuId';
    const String username = 'username';
    const String password = 'password';
    const String salt = 'salt';

    test(
      'should call the [BoxDataSource.createUser] and complete successfully '
      'when the call to the box source is successful',
      () async {
        const int id = 1717;
        const EitherResult<int> expectedResult = RightResult<int>(id);
        when(() {
          return _dataSource.createUser(
            uuId: any(named: uuIdKey),
            username: any(named: usernameKey),
            passwordHash: any(named: passwordHashKey),
            salt: any(named: saltKey),
          );
        }).thenAnswer((_) async => id);

        final EitherResult<int> result = await _repository.createUser(
          uuId: uuId,
          username: username,
          passwordHash: password,
          salt: salt,
        );

        expect(result, expectedResult);

        final VerificationResult verifyResult = verify(() {
          return _dataSource.createUser(
            uuId: captureAny(named: uuIdKey),
            username: captureAny(named: usernameKey),
            passwordHash: captureAny(named: passwordHashKey),
            salt: captureAny(named: saltKey),
          );
        });
        expect(verifyResult.callCount, 1);
        expect(verifyResult.captured, const <String>[uuId, username, password, salt]);

        verifyNoMoreInteractions(_dataSource);
      },
    );

    test(
      'should return a [DatabaseFailure] when the call to the box source is unsuccessful',
      () async {
        const DatabaseException exception = DatabaseExceptionUnknown();

        when(() {
          return _dataSource.createUser(
            uuId: any(named: uuIdKey),
            username: any(named: usernameKey),
            passwordHash: any(named: passwordHashKey),
            salt: any(named: saltKey),
          );
        }).thenThrow(exception);

        final EitherResult<void> result = await _repository.createUser(
          uuId: uuId,
          username: username,
          passwordHash: password,
          salt: salt,
        );

        expect(result, LeftResult<int>(DatabaseFailure(message: exception.message)));

        final VerificationResult verifyResult = verify(() {
          return _dataSource.createUser(
            uuId: captureAny(named: uuIdKey),
            username: captureAny(named: usernameKey),
            passwordHash: captureAny(named: passwordHashKey),
            salt: captureAny(named: saltKey),
          );
        });
        expect(verifyResult.callCount, 1);
        expect(verifyResult.captured, const <String>[uuId, username, password, salt]);

        verifyNoMoreInteractions(_dataSource);
      },
    );
  });

  group('hasUsers', () {
    test(
      'should call the [BoxDataSource.hasUsers] and complete successfully '
      'when the call to the box source is successful',
      () async {
        const bool hasUsers = true;
        when(_dataSource.hasUsers).thenAnswer((_) async => hasUsers);

        final EitherResult<bool> result = await _repository.hasUsers();
        expect(result, const RightResult<bool>(hasUsers));

        verify(_dataSource.hasUsers).calledOnce();
        verifyNoMoreInteractions(_dataSource);
      },
    );

    test(
      'should return a [DatabaseFailure] when the call to the box source is unsuccessful',
      () async {
        const DatabaseException exception = DatabaseExceptionUnknown();
        when(_dataSource.hasUsers).thenThrow(exception);
        
        final EitherResult<bool> result = await _repository.hasUsers();
        expect(result, LeftResult<bool>(DatabaseFailure(message: exception.message)));

        verify(_dataSource.hasUsers).calledOnce();
        verifyNoMoreInteractions(_dataSource);
      },
    );
  });
}
