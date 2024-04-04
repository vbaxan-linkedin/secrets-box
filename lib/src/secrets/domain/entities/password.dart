part of secrets_entities;

final class Password extends Equatable {
  const Password(this.password);

  final String password;

  @override
  List<Object?> get props => <Object?>[password];
}