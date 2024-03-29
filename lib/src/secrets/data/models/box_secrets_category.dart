part of secrets_data_models;

@Entity()
class BoxSecretsCategory {
  BoxSecretsCategory({
    this.id = 0,
    required this.categoryId,
    required this.userId,
    required this.name,
  });

  int id;

  @Unique(onConflict: ConflictStrategy.replace)
  final String categoryId;

  final String userId;

  final String name;
}
