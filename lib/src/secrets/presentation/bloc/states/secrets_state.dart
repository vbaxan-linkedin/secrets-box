part of secrets_states;

sealed class SecretsState extends Equatable {
  const SecretsState();
}

final class SecretsInitial extends SecretsState {
  @override
  List<Object> get props => [];
}
