part of secrets_data_models;

@Entity()
class BoxPasswordSecret extends BoxSecret {
  BoxPasswordSecret({
    this.id = 0,
    required this.entityId,
    required this.secretsEntryId,
    required this.userId,
    required this.name,
    required this.password,
  }) : super(
          boxId: id,
          secretId: entityId,
          secretEntryId: secretsEntryId,
          usrId: userId,
          secretName: name,
        );

  int id;

  @Unique(onConflict: ConflictStrategy.replace)
  final String entityId;

  final String secretsEntryId;

  final String userId;

  final String? name;

  final String password;
}
