part of auth_states;

final class LoggingInUser extends AuthState {
  const LoggingInUser();
}

final class UserLoggedIn extends AuthState {
  const UserLoggedIn({required this.userId});

  final String userId;
}