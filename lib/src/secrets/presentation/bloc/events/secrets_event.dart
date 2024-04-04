part of secrets_events;

abstract base class SecretsEvent extends Equatable {
  const SecretsEvent({required this.userId});

  final String userId;

  @override
  List<Object?> get props => <Object?>[userId];
}
