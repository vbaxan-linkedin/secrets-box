import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/core/domain/use_case/generate_uuid.dart';
import 'package:secrets_box/src/core/domain/use_case/app_uuid.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import '../../../core/utils.dart';
import 'mocks.dart';

late final AppUuid _uuid;
late final GenerateUuid _generateUuid;

void main() {
  setUpAll(() {
    _uuid = AppUuidMock();
    _generateUuid = GenerateUuid(_uuid);
  });

  setUp(() {
    reset(_uuid);
  });

  tearDown(resetMocktailState);

  const String uuid = 'generated uuid';

  test(
    'should return a generated uuid if [AppUuid.v4] call succeeds',
    () async {
      when(_uuid.generateV4Uuid).thenReturn(uuid);

      final EitherResult<String> result = await _generateUuid();

      expect(result, const RightResult<String>(uuid));

      verify(_uuid.generateV4Uuid).calledOnce();
      verifyNoMoreInteractions(_uuid);
    },
  );

  test(
    'should return a [UuidFailure] [AppUuid.v4] call throws',
    () async {
      final Exception exception = Exception();
      when(_uuid.generateV4Uuid).thenThrow(exception);

      final EitherResult<String> result = await _generateUuid();

      expect(result, const LeftResult<String>(UuidFailure()));

      verify(_uuid.generateV4Uuid).calledOnce();
      verifyNoMoreInteractions(_uuid);
    },
  );
}
