import 'package:secrets_box/src/auth/data/datasources/index.dart';
import 'package:secrets_box/src/auth/data/models/box_user.dart';
import 'package:secrets_box/src/auth/domain/entities/index.dart';
import 'package:secrets_box/src/auth/domain/repositories/auth_repository.dart';
import 'package:secrets_box/src/core/domain/entities/index.dart';
import 'package:secrets_box/src/core/errors/exceptions.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';

final class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this._authBoxDataSource);

  final AuthBoxDataSource _authBoxDataSource;

  @override
  ResultFuture<int> createUser({
    required String uuId,
    required String username,
    required String passwordHash,
    required String salt,
  }) async {
    try {
      final int id = await _authBoxDataSource.createUser(
        uuId: uuId,
        username: username,
        passwordHash: passwordHash,
        salt: salt,
      );
      return SuccessResult<int>(data: id);
    } on DatabaseException catch(e) {
      return ErrorResult<int>(failure: DatabaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> hasUsers() async {
    try {
      final bool hasUsers = await _authBoxDataSource.hasUsers();
      return SuccessResult<bool>(data: hasUsers);
    } on DatabaseException catch(e) {
      return ErrorResult<bool>(failure: DatabaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<User?> findUser(String username) async {
    try {
      final BoxUser? boxUser = await _authBoxDataSource.findUser(username);
      return SuccessResult<User?>(data: boxUser?.toDomainModel());
    } on DatabaseException catch(e) {
      return ErrorResult<User>(failure: DatabaseFailure.fromException(e));
    }
  }
}
