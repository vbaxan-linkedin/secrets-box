part of secrets_use_cases;

class CreateSecretsEntry implements UseCaseWithParams<int, CreateSecretsEntryParams> {
  const CreateSecretsEntry(this._repository);

  final SecretsRepository _repository;

  @override
  ResultFuture<int> call(CreateSecretsEntryParams params) {
    return _repository.createSecretsEntry(
      secretsEntryId: params.secretsEntryId,
      userId: params.userId,
      categoryId: params.categoryId,
      title: params.title,
    );
  }
}

class CreateSecretsEntryParams extends Equatable {
  const CreateSecretsEntryParams({
    required this.secretsEntryId,
    required this.userId,
    this.categoryId,
    required this.title,
  });

  final String secretsEntryId;
  final String userId;
  final String? categoryId;
  final String title;

  @override
  List<Object?> get props => <Object?>[secretsEntryId, userId, categoryId, title];
}
