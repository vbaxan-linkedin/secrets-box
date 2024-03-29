import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:objectbox/objectbox.dart';
import 'package:secrets_box/src/auth/data/datasources/auth_box_data_source.dart';
import 'package:secrets_box/src/auth/data/datasources/users_box_query_conditions.dart';
import 'package:secrets_box/src/auth/data/models/box_user.dart';
import 'package:secrets_box/src/core/errors/exceptions.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import '../../../core/data/datasources/mocks.dart';
import '../../../core/utils.dart';
import '../../argument_keys.dart';
import 'fakes.dart';

const String _uuId = 'uuId';
const String _username = 'username';
const String _password = 'password';
const String _salt = 'salt';

late final Box<BoxUser> _usersBox;
late final UsersBoxQueryConditions _conditions;
late final AuthBoxDataSource _dataSource;

void main() {
  setUpAll(() {
    _usersBox = BoxMock<BoxUser>();
    _conditions = UsersBoxQueryConditionsMock();
    _dataSource = AuthBoxDataSourceImpl(_usersBox, _conditions);
    registerFallbackValue(BoxUserFake());
    registerFallbackValue(PutMode.put);
  });

  setUp(() {
    reset(_usersBox);
    reset(_conditions);
  });

  tearDown(resetMocktailState);

  group('createUser', () {
    test(
      'should complete successfully when [Box.put] completes successfully',
      () async {
        const int id = 1717;

        when(() {
          return _usersBox.put(
            any(),
            mode: any(named: modeKey),
          );
        }).thenReturn(id);

        final int result = await _dataSource.createUser(
          uuId: _uuId,
          username: _username,
          passwordHash: _password,
          salt: _salt,
        );

        expect(result, id);

        _verifyCreateUserResults();
      },
    );

    test(
      'should throw [DatabaseUniqueViolationException] when [Box.put] throws a [UniqueViolationException]',
      () async {
        await _testCreateUserError(
          exception: UniqueViolationException('User with this username already exists'),
          databaseExceptionProducer: (UniqueViolationException e) {
            return DatabaseUniqueViolationException(e.message);
          },
        );
      },
    );

    test(
      'should throw [DatabaseExceptionUnknown] when [Box.put] throws some other [Exception]',
      () async {
        await _testCreateUserError(
          exception: Exception(),
          databaseExceptionProducer: (_) => const DatabaseExceptionUnknown(),
        );
      },
    );
  });

  group('hasUsers', () {
    test(
      'should complete successfully when [Box.isEmpty] completes successfully',
      () async {
        const bool expected = true;
        when(_usersBox.isEmpty).thenReturn(expected);

        final bool result = await _dataSource.hasUsers();
        expect(result, !expected);

        verify(_usersBox.isEmpty).calledOnce();
        verifyNoMoreInteractions(_usersBox);
      },
    );
  });

  group('findUser', () {
    test(
      'should complete successfully',
      () async {
        const String username = 'username';
        final BoxUser user = BoxUser.test();

        final Condition<BoxUser> condition = ConditionMock<BoxUser>();
        final Query<BoxUser> query = QueryMock<BoxUser>();
        final QueryBuilder<BoxUser> queryBuilder = QueryBuilderMock<BoxUser>();

        when(() => _conditions.userNameEquals(any())).thenReturn(condition);
        when(query.findFirst).thenReturn(user);
        when(query.close).thenAnswer((_) => Completer<void>());
        when(queryBuilder.build).thenReturn(query);
        when(() => _usersBox.query(any())).thenReturn(queryBuilder);

        final BoxUser? result = await _dataSource.findUser(username);
        expect(result, user);

        VerificationResult verifyResult = verify(() => _conditions.userNameEquals(captureAny()));
        expect(verifyResult.callCount, 1);
        expect(verifyResult.captured, const <String>[username]);
        verifyNoMoreInteractions(_conditions);

        verifyResult = verify(query.findFirst);
        expect(verifyResult.callCount, 1);
        verifyResult = verify(query.close);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(query);

        verifyResult = verify(queryBuilder.build);
        expect(verifyResult.callCount, 1);
        verifyNoMoreInteractions(queryBuilder);

        verifyResult = verify(() => _usersBox.query(captureAny()));
        expect(verifyResult.callCount, 1);
        expect(verifyResult.captured, <Object>[condition]);
        verifyNoMoreInteractions(_usersBox);
      },
    );
  });
}

Future<void> _testCreateUserError<T extends Exception>({
  required T exception,
  required EntityTransformation<T, DatabaseException> databaseExceptionProducer,
}) async {
  when(() {
    return _usersBox.put(
      any(),
      mode: any(named: modeKey),
    );
  }).thenThrow(exception);

  expect(
    () {
      return _dataSource.createUser(
        uuId: _uuId,
        username: _username,
        passwordHash: _password,
        salt: _salt,
      );
    },
    throwsA(databaseExceptionProducer(exception)),
  );

  _verifyCreateUserResults();
}

void _verifyCreateUserResults() {
  final TypeMatcher<BoxUser> userMatcher = isA<BoxUser>()
      .having(
        (BoxUser user) => user.uuId,
        uuIdKey,
        _uuId,
      )
      .having(
        (BoxUser user) => user.username,
        usernameKey,
        _username,
      )
      .having(
        (BoxUser user) => user.passwordHash,
        passwordHashKey,
        _password,
      )
      .having(
        (BoxUser user) => user.salt,
        saltKey,
        _salt,
      );

  final VerificationResult verifyResult = verify(() {
    return _usersBox.put(
      captureAny(),
      mode: captureAny(named: modeKey),
    );
  });
  expect(verifyResult.callCount, 1);
  expect(verifyResult.captured, <Object>[userMatcher, PutMode.insert]);

  verifyNoMoreInteractions(_usersBox);
}
