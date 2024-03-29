import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/domain/use_cases/create_user.dart';
import 'package:secrets_box/src/core/domain/use_case/generate_uuid.dart';
import 'package:secrets_box/src/auth/domain/use_cases/get_has_users.dart';
import 'package:secrets_box/src/core/domain/use_case/hash_string.dart';
import 'package:secrets_box/src/auth/presentation/bloc/index.dart';
import 'package:secrets_box/src/core/domain/use_case/get_now_date_time.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import 'fakes.dart';
import 'mocks.dart';

late final GetHasUsers _getHasUsers;
late final CreateUser _createUser;
late final HashString _hashString;
late final GenerateUuid _generateUuid;
late final GetNowDateTime _getNowDateTime;
late AuthBloc _authBloc;

void main() {
  setUpAll(() {
    _getHasUsers = GetHasUsersMock();
    _createUser = CreateUserMock();
    _hashString = HashStringMock();
    _generateUuid = GenerateUuidMock();
    _getNowDateTime = GetNowDateTimeMock();

    registerFallbackValue(HashStringParamsFake());
    registerFallbackValue(CreateUserParamsFake());
  });

  setUp(() {
    <Object>[
      _getHasUsers,
      _createUser,
      _hashString,
      _generateUuid,
      _getNowDateTime,
    ].forEach(reset);
    _authBloc = AuthBloc(
      getHaUsers: _getHasUsers,
      createUser: _createUser,
      hashString: _hashString,
      generateUuid: _generateUuid,
      getNowDateTime: _getNowDateTime,
    );
  });

  tearDown(() {
    resetMocktailState();
    _authBloc.close();
  });

  test('initial state should be [AuthInitial]', () {
    expect(_authBloc.state, const AuthInitial());
  });

  group('createUser', () {
    const String username = 'user_name';
    const String password = 'password';
    const NowDateTimeFailure dateTimeFailure = NowDateTimeFailure();
    final DateTime now = DateTime.now();
    final String nowStr = now.toString();
    final HashStringFailure nowStrFailure = HashStringFailure(stringToHash: nowStr);
    const String salt = 'salt';
    const UuidFailure uuidFailure = UuidFailure();
    const String uuid = 'uuid';
    const String saltPass = salt + password;
    const HashStringFailure saltPassFailure = HashStringFailure(stringToHash: saltPass);
    const String hashedPassword = 'hashed_password';
    const String createUserFailedMessage = 'creating user has failed';

    blocTest(
      'should emit [CreatingUser, AuthError] when [NowDateTime] fails',
      build: () {
        when(_getNowDateTime).thenAnswer((_) async => const LeftResult<DateTime>(dateTimeFailure));
        return _authBloc;
      },
      act: (AuthBloc bloc) {
        bloc.add(const CreateUserEvent(username: username, password: password));
      },
      expect: () {
        return <AuthState>[
          const CreatingUser(),
          AuthError(dateTimeFailure.message),
        ];
      },
      verify: (_) {
        final VerificationResult verifyResult = verify(_getNowDateTime);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_getNowDateTime);
      },
    );

    blocTest(
      'should emit [CreatingUser, AuthError] when [NowDateTime] succeeds, but [HashString] fails for salt',
      build: () {
        when(_getNowDateTime).thenAnswer((_) async => RightResult<DateTime>(now));
        when(() => _hashString(any())).thenAnswer((_) async => LeftResult<String>(nowStrFailure));
        return _authBloc;
      },
      act: (AuthBloc bloc) {
        bloc.add(const CreateUserEvent(username: username, password: password));
      },
      expect: () {
        return <AuthState>[
          const CreatingUser(),
          AuthError(nowStrFailure.message),
        ];
      },
      verify: (_) {
        VerificationResult verifyResult = verify(_getNowDateTime);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_getNowDateTime);

        verifyResult = verify(() => _hashString(captureAny()));
        expect(verifyResult.callCount, 1);
        expect(verifyResult.captured, <Object>[HashStringParams(nowStr)]);
        verifyNoMoreInteractions(_hashString);
      },
    );

    blocTest(
      'should emit [CreatingUser, AuthError] when [NowDateTime] succeeds, [HashString] succeeds for salt, '
      'but [GenerateUuid] fails',
      build: () {
        when(_getNowDateTime).thenAnswer((_) async => RightResult<DateTime>(now));
        when(() => _hashString(any())).thenAnswer((_) async => const RightResult<String>(salt));
        when(_generateUuid).thenAnswer((_) async => const LeftResult<String>(uuidFailure));
        return _authBloc;
      },
      act: (AuthBloc bloc) {
        bloc.add(const CreateUserEvent(username: username, password: password));
      },
      expect: () {
        return <AuthState>[
          const CreatingUser(),
          AuthError(uuidFailure.message),
        ];
      },
      verify: (_) {
        VerificationResult verifyResult = verify(_getNowDateTime);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_getNowDateTime);

        verifyResult = verify(() => _hashString(captureAny()));
        expect(verifyResult.callCount, 1);
        expect(verifyResult.captured, <Object>[HashStringParams(nowStr)]);
        verifyNoMoreInteractions(_hashString);

        verifyResult = verify(_generateUuid);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_generateUuid);
      },
    );

    blocTest(
      'should emit [CreatingUser, AuthError] when [NowDateTime] succeeds, [HashString] succeeds for salt, '
      '[GenerateUuid] succeeds, but [HashString] fails for salt + password',
      build: () {
        when(_getNowDateTime).thenAnswer((_) async => RightResult<DateTime>(now));
        when(() => _hashString(any())).thenAnswer((_) async => const RightResult<String>(salt));
        when(_generateUuid).thenAnswer((_) async => const RightResult<String>(uuid));
        when(() {
          return _hashString(const HashStringParams(saltPass));
        }).thenAnswer((_) async {
          return const LeftResult<String>(saltPassFailure);
        });
        return _authBloc;
      },
      act: (AuthBloc bloc) {
        bloc.add(const CreateUserEvent(username: username, password: password));
      },
      expect: () {
        return <AuthState>[
          const CreatingUser(),
          AuthError(saltPassFailure.message),
        ];
      },
      verify: (_) {
        VerificationResult verifyResult = verify(_getNowDateTime);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_getNowDateTime);

        verifyResult = verify(() => _hashString(captureAny()));
        expect(verifyResult.callCount, 2);
        expect(verifyResult.captured, <Object>[HashStringParams(nowStr), const HashStringParams(saltPass)]);
        verifyNoMoreInteractions(_hashString);

        verifyResult = verify(_generateUuid);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_generateUuid);
      },
    );

    blocTest(
      'should emit [CreatingUser, AuthError] when [NowDateTime] succeeds, [HashString] succeeds for salt, '
      '[GenerateUuid] succeeds, [HashString] succeeds for salt + password, but [CreateUser] fails',
      build: () {
        when(_getNowDateTime).thenAnswer((_) async => RightResult<DateTime>(now));
        when(() => _hashString(any())).thenAnswer((_) async => const RightResult<String>(salt));
        when(_generateUuid).thenAnswer((_) async => const RightResult<String>(uuid));
        when(() {
          return _hashString(const HashStringParams(saltPass));
        }).thenAnswer((_) async {
          return const RightResult<String>(hashedPassword);
        });
        when(() {
          return _createUser(any());
        }).thenAnswer((_) async {
          return const LeftResult<int>(DatabaseFailure(message: createUserFailedMessage));
        });
        return _authBloc;
      },
      act: (AuthBloc bloc) {
        bloc.add(const CreateUserEvent(username: username, password: password));
      },
      expect: () {
        return const <AuthState>[
          CreatingUser(),
          AuthError(createUserFailedMessage),
        ];
      },
      verify: (_) {
        VerificationResult verifyResult = verify(_getNowDateTime);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_getNowDateTime);

        verifyResult = verify(() => _hashString(captureAny()));
        expect(verifyResult.callCount, 2);
        expect(verifyResult.captured, <Object>[HashStringParams(nowStr), const HashStringParams(saltPass)]);
        verifyNoMoreInteractions(_hashString);

        verifyResult = verify(_generateUuid);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_generateUuid);

        verifyResult = verify(() => _createUser(captureAny()));
        expect(verifyResult.callCount, 1);
        expect(
          verifyResult.captured,
          const <Object>[
            CreateUserParams(
              uuId: uuid,
              username: username,
              passwordHash: hashedPassword,
              salt: salt,
            ),
          ],
        );
        verifyNoMoreInteractions(_hashString);
      },
    );

    blocTest(
      'should emit [CreatingUser, UserCreated] when [NowDateTime] succeeds, [HashString] succeeds for salt, '
      '[GenerateUuid] succeeds, [HashString] succeeds for salt + password, and [CreateUser] succeeds',
      build: () {
        when(_getNowDateTime).thenAnswer((_) async => RightResult<DateTime>(now));
        when(() => _hashString(any())).thenAnswer((_) async => const RightResult<String>(salt));
        when(_generateUuid).thenAnswer((_) async => const RightResult<String>(uuid));
        when(() {
          return _hashString(const HashStringParams(saltPass));
        }).thenAnswer((_) async {
          return const RightResult<String>(hashedPassword);
        });
        when(() => _createUser(any())).thenAnswer((_) async => const RightResult<int>(1));
        return _authBloc;
      },
      act: (AuthBloc bloc) {
        bloc.add(const CreateUserEvent(username: username, password: password));
      },
      expect: () {
        return const <AuthState>[
          CreatingUser(),
          UserCreated(),
        ];
      },
      verify: (_) {
        VerificationResult verifyResult = verify(_getNowDateTime);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_getNowDateTime);

        verifyResult = verify(() => _hashString(captureAny()));
        expect(verifyResult.callCount, 2);
        expect(verifyResult.captured, <Object>[HashStringParams(nowStr), const HashStringParams(saltPass)]);
        verifyNoMoreInteractions(_hashString);

        verifyResult = verify(_generateUuid);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(_generateUuid);

        verifyResult = verify(() => _createUser(captureAny()));
        expect(verifyResult.callCount, 1);
        expect(
          verifyResult.captured,
          const <Object>[
            CreateUserParams(
              uuId: uuid,
              username: username,
              passwordHash: hashedPassword,
              salt: salt,
            ),
          ],
        );
        verifyNoMoreInteractions(_hashString);
      },
    );
  });
}
