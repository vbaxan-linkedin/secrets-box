part of secrets_events;

final class StoreCreateSecretsEntryInfoEvent extends SecretsEvent {
  const StoreCreateSecretsEntryInfoEvent({
    this.info,
    this.title,
    this.categories,
    this.secrets,
  });

  final CreateSecretsEntryInfo? info;
  final NewStateValue<String>? title;
  final NewStateValue<List<SecretsCategory>>? categories;
  final NewStateValue<List<Secret<dynamic>>>? secrets;

  @override
  List<Object?> get props {
    return <Object?>[
      info,
      title,
      categories,
      secrets,
    ];
  }
}
