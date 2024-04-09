part of secrets_entities;

final class CreateSecretsEntryInfo extends Equatable {
  const CreateSecretsEntryInfo._({
    required this.secretsEntryId,
    required this.title,
    required this.categories,
    required this.secrets,
  });

  factory CreateSecretsEntryInfo.empty() {
    return const CreateSecretsEntryInfo._(
      secretsEntryId: null,
      title: null,
      categories: <SecretsCategory>[],
      secrets: <Secret<dynamic>>[],
    );
  }

  factory CreateSecretsEntryInfo.from({
    required SecretsEntry entry,
    required List<SecretsCategory> categories,
    required List<Secret<dynamic>> secrets,
  }) {
    return CreateSecretsEntryInfo._(
      secretsEntryId: entry.secretsEntryId,
      title: entry.title,
      categories: categories,
      secrets: secrets,
    );
  }

  final String? secretsEntryId;
  final String? title;
  final List<SecretsCategory> categories;
  final List<Secret<dynamic>> secrets;

  @override
  List<Object?> get props {
    return <Object?>[
      secretsEntryId,
      title,
      categories,
      secrets,
    ];
  }
}
