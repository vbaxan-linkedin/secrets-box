part of secrets_use_cases;

class CreateSecretsEntry implements UseCaseWithParams<int, CreateSecretsEntryParams> {
  const CreateSecretsEntry(this._repository);

  final SecretsRepository _repository;

  @override
  ResultFuture<int> call(CreateSecretsEntryParams params) {
    return _repository.createSecretsEntry(
        secretsEntryId: params.secretsEntryId,
        userId: params.userId,
        title: params.title,
        categories: params.categories,
        secrets: params.secrets,
    );
  }
}

class CreateSecretsEntryParams extends Equatable {
  const CreateSecretsEntryParams({
    required this.secretsEntryId,
    required this.userId,
    required this.title,
    required this.categories,
    required this.secrets,
  });

  final String secretsEntryId;
  final String userId;
  final String title;
  final List<SecretsCategory> categories;
  final List<Secret<dynamic>> secrets;

  @override
  List<Object?> get props => <Object?>[secretsEntryId, userId, title, categories, secrets,];
}
