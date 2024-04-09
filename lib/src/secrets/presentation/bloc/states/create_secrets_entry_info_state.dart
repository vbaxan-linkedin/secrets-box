part of secrets_states;

final class CreateSecretsEntryInfoState extends SecretsState {
  const CreateSecretsEntryInfoState._({
    this.secretsEntryId,
    this.title,
    required this.categories,
    required this.secrets,
  });

  factory CreateSecretsEntryInfoState.empty() {
    return const CreateSecretsEntryInfoState._(
      secretsEntryId: null,
      title: null,
      categories: <SecretsCategory>[],
      secrets: <Secret<dynamic>>[],
    );
  }

  factory CreateSecretsEntryInfoState.fromInfo(CreateSecretsEntryInfo info) {
    return CreateSecretsEntryInfoState._(
      secretsEntryId: info.secretsEntryId,
      title: info.title,
      categories: info.categories,
      secrets: info.secrets,
    );
  }

  final String? secretsEntryId;
  final String? title;
  final List<SecretsCategory> categories;
  final List<Secret<dynamic>> secrets;


  CreateSecretsEntryInfoState copyWith({
    NewStateValue<String>? title,
    NewStateValue<List<SecretsCategory>>? categories,
    NewStateValue<List<Secret<dynamic>>>? secrets,
}) {
    return CreateSecretsEntryInfoState._(
      secretsEntryId: secretsEntryId,
      title: title.valueOr(this.title),
      categories: categories.valueOr(this.categories).toFixedNonNullableList(),
      secrets: secrets.valueOr(this.secrets).toFixedNonNullableList(),
    );
  }

  @override
  List<Object?> get props {
    return <Object?>[
      ...super.props,
      secretsEntryId,
      title,
      categories,
      secrets,
    ];
  }
}
