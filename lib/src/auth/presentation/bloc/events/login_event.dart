part of auth_events;

final class LoginEvent extends AuthEvent {
  const LoginEvent({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object?> get props => <Object?>[username, password];
}