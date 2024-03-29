part of secrets_entities;

final class SecretsCategory extends Equatable {
  const SecretsCategory({
    required this.categoryId,
    required this.userId,
    required this.name,
  });

  final String categoryId;
  final String userId;
  final String name;

  @override
  List<Object?> get props => <Object?>[categoryId, userId, name];
}
