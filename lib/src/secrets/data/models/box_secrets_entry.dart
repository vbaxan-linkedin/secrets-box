part of secrets_data_models;

@Entity()
class BoxSecretsEntry {
  BoxSecretsEntry({
    this.id = 0,
    required this.secretsEntryId,
    required this.userId,
    this.categoryId,
    required this.title,
  });

  int id;

  @Unique(onConflict: ConflictStrategy.replace)
  final String secretsEntryId;

  final String userId;

  final String? categoryId;

  final String title;

  SecretsEntry toDomainModel() {
    return SecretsEntry(
      secretsEntryId: secretsEntryId,
      userId: userId,
      categoryId: categoryId,
      title: title,
    );
  }
}
