part of secrets_states;

final class CreateSecretEntryInfo extends SecretsState {
  const CreateSecretEntryInfo._({
    required this.userId,
    required this.secretEntryId,
    required this.title,
    required this.categories,
    required this.secrets,
  });

  factory CreateSecretEntryInfo.empty(String userId) {
    return CreateSecretEntryInfo._(
      userId: userId,
      secretEntryId: null,
      title: null,
      categories: const <SecretsCategory>[],
      secrets: const <Secret<dynamic>>[],
    );
  }

  factory CreateSecretEntryInfo.from({
    required SecretsEntry entry,
    required List<SecretsCategory> categories,
    required List<Secret<dynamic>> secrets,
  }) {
    return CreateSecretEntryInfo._(
      userId: entry.userId,
      secretEntryId: entry.secretsEntryId,
      title: entry.title,
      categories: categories,
      secrets: secrets,
    );
  }

  final String userId;
  final String? secretEntryId;
  final String? title;
  final List<SecretsCategory> categories;
  final List<Secret<dynamic>> secrets;

  @override
  List<Object?> get props {
    return <Object?>[
      ...super.props,
      userId,
      secretEntryId,
      title,
      categories,
      secrets,
    ];
  }
}
