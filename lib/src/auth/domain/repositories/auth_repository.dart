import 'package:secrets_box/src/auth/domain/entities/index.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

abstract interface class AuthRepository {
  const AuthRepository();

  ResultFuture<int> createUser({
    required String uuId,
    required String username,
    required String passwordHash,
    required String salt,
  });

  ResultFuture<bool> hasUsers();

  ResultFuture<User?> findUser(String username);
}
