part of secrets_data_models;

@Entity()
class BoxSecretsEntry {
  BoxSecretsEntry({
    this.id = 0,
    required this.secretsEntryId,
    required this.userId,
    required this.title,
    required this.categoryIds,
    required this.secretIds,
  });

  int id;

  @Unique(onConflict: ConflictStrategy.replace)
  final String secretsEntryId;

  final String userId;

  final String title;

  final List<String> categoryIds;

  final List<String> secretIds;

  SecretsEntry toDomainModel() {
    return SecretsEntry(
      secretsEntryId: secretsEntryId,
      title: title,
      categoryIds: categoryIds,
      secretIds: secretIds,
    );
  }
}
