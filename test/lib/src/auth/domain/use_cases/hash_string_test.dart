import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:secrets_box/src/core/domain/use_case/hash_string.dart';
import 'package:secrets_box/src/core/domain/use_case/app_hash.dart';
import 'package:secrets_box/src/core/domain/use_case/app_utf8_codec.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

import 'mocks.dart';

late final AppUtf8Codec _utf8codec;
late final AppHash _hash;
late final HashString _hashString;

void main() {
  setUpAll(() {
    _utf8codec = AppUtf8CodecMock();
    _hash = AppHashMock();
    _hashString = HashString(utf8codec: _utf8codec, hash: _hash);
  });

  setUp(() {
    <Object>[_utf8codec, _hash].forEach(reset);
  });

  tearDown(resetMocktailState);

  const List<int> intList = <int>[1, 2, 3];
  final Uint8List unsignedInt8list = Uint8List.fromList(intList);
  final Digest digest = Digest(intList);
  const HashStringParams params = HashStringParams('input string');

  test(
    'should return a right result containing the hash converted result.',
    () async {
      when(() => _utf8codec.encode(any())).thenReturn(unsignedInt8list);
      when(() => _hash.convert(any())).thenReturn(digest);

      final EitherResult<String> result = await _hashString(params);

      expect(result, RightResult<String>(digest.toString()));

      VerificationResult verifyResult = verify(() => _utf8codec.encode(captureAny()));
      expect(verifyResult.callCount, 1);
      expect(verifyResult.captured, <Object>[params.stringToHash]);
      verifyNoMoreInteractions(_utf8codec);

      verifyResult = verify(() => _hash.convert(captureAny()));
      expect(verifyResult.callCount, 1);
      expect(verifyResult.captured, <Object>[intList]);
      verifyNoMoreInteractions(_hash);
    },
  );

  final Exception exception = Exception('exception message');

  test(
    'should return a [HashStringFailure] if any of [AppUtf8Codec] or [AppHash] throws',
    () async {

      when(() => _utf8codec.encode(any())).thenThrow(exception);

      EitherResult<String> result = await _hashString(params);

      expect(result, LeftResult<String>(HashStringFailure(stringToHash: params.stringToHash)));

      VerificationResult verifyResult = verify(() => _utf8codec.encode(captureAny()));
      expect(verifyResult.callCount, 1);
      expect(verifyResult.captured, <Object>[params.stringToHash]);
      verifyNoMoreInteractions(_utf8codec);
      verifyZeroInteractions(_hash);

      when(() => _utf8codec.encode(any())).thenReturn(unsignedInt8list);
      when(() => _hash.convert(any())).thenThrow(exception);

      result = await _hashString(params);

      expect(result, LeftResult<String>(HashStringFailure(stringToHash: params.stringToHash)));

      verifyResult = verify(() => _utf8codec.encode(captureAny()));
      expect(verifyResult.callCount, 1);
      expect(verifyResult.captured, <Object>[params.stringToHash]);
      verifyNoMoreInteractions(_utf8codec);

      verifyResult = verify(() => _hash.convert(captureAny()));
      expect(verifyResult.callCount, 1);
      expect(verifyResult.captured, <Object>[intList]);
      verifyNoMoreInteractions(_hash);
    },
  );
}
