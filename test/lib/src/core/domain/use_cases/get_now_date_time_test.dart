import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/core/domain/use_case/app_date_time.dart';
import 'package:secrets_box/src/core/domain/use_case/get_now_date_time.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import '../../utils.dart';
import 'mocks.dart';

late final AppDateTime _appDateTime;
late final GetNowDateTime _getNowDateTime;

void main() {
  setUpAll(() {
    _appDateTime = AppDateTimeMock();
    _getNowDateTime = GetNowDateTime(_appDateTime);
  });

  setUp(() {
    reset(_appDateTime);
  });

  tearDown(resetMocktailState);

  final DateTime now = DateTime.now();

  test(
    'should return a generated uuid if [AppUuid.v4] call succeeds',
    () async {
      when(_appDateTime.now).thenReturn(now);

      final EitherResult<DateTime> result = await _getNowDateTime();

      expect(result, RightResult<DateTime>(now));

      verify(_appDateTime.now).calledOnce();
      verifyNoMoreInteractions(_appDateTime);
    },
  );

  test(
    'should return a [NowDateTimeFailure] if [AppDateTime.now] call throws',
    () async {
      final Exception exception = Exception();
      when(_appDateTime.now).thenThrow(exception);

      final EitherResult<DateTime> result = await _getNowDateTime();

      expect(result, const LeftResult<DateTime>(NowDateTimeFailure()));

      verify(_appDateTime.now).calledOnce();
      verifyNoMoreInteractions(_appDateTime);
    },
  );
}
