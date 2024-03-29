part of secrets_use_cases;

class FetchSecretsEntries implements UseCaseWithParams<List<SecretsEntry>, FetchSecretsEntriesParams> {
  const FetchSecretsEntries(this._repository);

  final SecretsRepository _repository;

  @override
  ResultFuture<List<SecretsEntry>> call(FetchSecretsEntriesParams params) {
    return _repository.fetchSecretsEntries(params.userId);
  }
}

class FetchSecretsEntriesParams extends Equatable {
  const FetchSecretsEntriesParams(this.userId);

  final String userId;

  @override
  List<Object?> get props => <Object?>[userId];
}