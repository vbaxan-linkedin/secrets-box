part of auth_entities;

final class User extends Equatable {
  const User({
    required this.uuId,
    required this.username,
    required this.passwordHash,
    required this.salt,
  });

  final String uuId;
  final String username;
  final String passwordHash;
  final String salt;

  @override
  List<Object?> get props => <Object>[uuId, username, passwordHash, salt];
}
