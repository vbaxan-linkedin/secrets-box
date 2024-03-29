part of secrets_entities;

final class SecretsEntry extends Equatable {
  const SecretsEntry({
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