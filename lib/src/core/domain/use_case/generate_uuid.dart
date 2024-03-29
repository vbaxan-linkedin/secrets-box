part of core_use_cases;

class GenerateUuid implements UseCaseWithoutParams<String> {
  const GenerateUuid(this._uuid);

  final AppUuid _uuid;

  @override
  ResultFuture<String> call() async {
    try {
      return SuccessResult<String>(data: _uuid.generateV4Uuid());
    } catch(e) {
      return const ErrorResult<String>(failure: UuidFailure());
    }
  }
}