part of auth_states;

abstract base class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => <Object>[];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => <Object>[message];
}


