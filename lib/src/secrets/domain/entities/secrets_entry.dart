part of secrets_entities;

final class SecretsEntry extends Equatable {
  const SecretsEntry({
    required this.secretsEntryId,
    required this.title,
    required this.categoryIds,
    required this.secretIds,
  });

  final String secretsEntryId;
  final String title;
  final List<String> categoryIds;
  final List<String> secretIds;

  @override
  List<Object?> get props {
    return <Object?>[
      secretsEntryId,
      title,
      categoryIds,
      secretIds,
    ];
  }
}
