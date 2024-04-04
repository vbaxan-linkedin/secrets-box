part of secrets_states;

final class FetchingSecretsEntries extends SecretsState {
  const FetchingSecretsEntries();
}

final class SecretsEntriesFetched extends SecretsState {
  const SecretsEntriesFetched({
    required this.entries,
  });

  final List<SecretsEntry> entries;

  @override
  List<Object?> get props => <Object?>[...super.props, entries];
}
