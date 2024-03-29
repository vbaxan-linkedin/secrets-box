part of core_use_cases;

class HashString implements UseCaseWithParams<String, HashStringParams> {
  const HashString({
    required AppUtf8Codec utf8codec,
    required AppHash hash,
  })  : _utf8codec = utf8codec,
        _hash = hash;

  final AppUtf8Codec _utf8codec;
  final AppHash _hash;

  @override
  ResultFuture<String> call(HashStringParams params) async {
    try {
      final Uint8List nowEncoded = _utf8codec.encode(params.stringToHash);
      return SuccessResult<String>(data: _hash.convert(nowEncoded).toString());
    } catch (e) {
      return ErrorResult<String>(failure: HashStringFailure(stringToHash: params.stringToHash));
    }
  }
}

class HashStringParams extends Equatable {
  const HashStringParams(this.stringToHash);

  final String stringToHash;

  @override
  List<Object?> get props => <Object?>[stringToHash];
}
