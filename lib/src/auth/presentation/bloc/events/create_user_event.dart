part of auth_events;

final class CreateUserEvent extends AuthEvent {
  const CreateUserEvent({
    required this.username,
    required this.password,
    required this.repeatPassword,
  });

  final String username;
  final String password;
  final String repeatPassword;

  @override
  List<Object?> get props => <Object?>[username, password, repeatPassword];
}