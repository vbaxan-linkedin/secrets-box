part of secrets_states;

abstract base class SecretsState extends Equatable {
  const SecretsState();

  @override
  List<Object?> get props => const <Object?>[];
}

final class SecretsInitial extends SecretsState {
  const SecretsInitial();
}

final class SecretsError extends SecretsState {
  const SecretsError({
    required this.message,
  });

  final String message;

  @override
  List<Object?> get props => <Object?>[...super.props, message];
}
