part of auth_datasources;

abstract interface class AuthBoxDataSource {
  const AuthBoxDataSource();

  Future<int> createUser({
    required String uuId,
    required String username,
    required String passwordHash,
    required String salt,
  });

  Future<bool> hasUsers();

  Future<BoxUser?> findUser(String username);
}
