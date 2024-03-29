import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/auth/domain/repositories/auth_repository.dart';
import 'package:secrets_box/src/auth/domain/use_cases/get_has_users.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import 'mocks.dart';

late final AuthRepository _repo;
late final GetHasUsers _getHaUsers;

void main() {
  setUpAll(() {
    _repo = AuthRepositoryMock();
    _getHaUsers = GetHasUsers(_repo);
  });

  setUp(() {
    reset(_repo);
  });

  tearDown(resetMocktailState);

  test(
    'should call the [AuthRepository.hasUsers]',
    () async {
      const bool hasUsers = false;
      const RightResult<bool> expectedResult = RightResult<bool>(hasUsers);

      when(_repo.hasUsers).thenAnswer((_) async => expectedResult);

      final EitherResult<bool> result = await _getHaUsers();
      expect(result, expectedResult);

      verify(_repo.hasUsers).called(1);
      verifyNoMoreInteractions(_repo);
    },
  );
}
