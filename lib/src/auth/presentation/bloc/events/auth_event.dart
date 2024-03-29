part of auth_events;

abstract base class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => <Object>[];
}
