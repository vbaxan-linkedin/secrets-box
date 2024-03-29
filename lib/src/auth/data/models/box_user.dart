import 'package:objectbox/objectbox.dart';
import 'package:secrets_box/src/auth/domain/entities/index.dart';

@Entity()
class BoxUser {
  BoxUser({
    this.id = 0,
    required this.uuId,
    required this.username,
    required this.passwordHash,
    required this.salt,
  });

  factory BoxUser.test() {
    return BoxUser(
      uuId: 'uuid',
      username: 'username',
      passwordHash: 'passwordHash',
      salt: 'salt'
    );
  }

  int id;

  @Unique(onConflict: ConflictStrategy.replace)
  final String uuId;

  @Unique(onConflict: ConflictStrategy.fail)
  final String username;

  final String passwordHash;

  final String salt;

  User toDomainModel() {
    return User(
      uuId: uuId,
      username: username,
      passwordHash: passwordHash,
      salt: salt,
    );
  }
}
