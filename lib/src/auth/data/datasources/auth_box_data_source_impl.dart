part of auth_datasources;

final class AuthBoxDataSourceImpl implements AuthBoxDataSource {
  const AuthBoxDataSourceImpl(this._usersBox, this._conditions);

  final Box<BoxUser> _usersBox;
  final UsersBoxQueryConditions _conditions;

  @override
  Future<int> createUser({
    required String uuId,
    required String username,
    required String passwordHash,
    required String salt,
  }) async {
    try {
      return _usersBox.put(
        BoxUser(
          uuId: uuId,
          username: username,
          passwordHash: passwordHash,
          salt: salt,
        ),
        mode: PutMode.insert,
      );
    } on UniqueViolationException catch (e) {
      throw DatabaseUniqueViolationException(e.message);
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }

  @override
  Future<bool> hasUsers() async {
    try {
      return _usersBox.isNotEmpty();
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }

  @override
  Future<BoxUser?> findUser(String username) async {
    try {
      final Query<BoxUser?> query = _usersBox.query(_conditions.userNameEquals(username)).build();
      final BoxUser? user = query.findFirst();
      query.close();
      return user;
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }
}
