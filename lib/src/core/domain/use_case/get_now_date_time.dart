part of core_use_cases;

class GetNowDateTime implements UseCaseWithoutParams<DateTime> {
  const GetNowDateTime(this._appDateTime);

  final AppDateTime _appDateTime;

  @override
  ResultFuture<DateTime> call() async {
    try {
      return SuccessResult<DateTime>(data: _appDateTime.now());
    } catch(e) {
      return const ErrorResult<DateTime>(failure: NowDateTimeFailure());
    }
  }
}