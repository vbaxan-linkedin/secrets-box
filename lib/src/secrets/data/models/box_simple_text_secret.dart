part of secrets_data_models;

@Entity()
class BoxSimpleTextSecret extends BoxSecret {
  BoxSimpleTextSecret({
    this.id = 0,
    required this.entityId,
    required this.userId,
    required this.secretsEntryId,
    required this.name,
    required this.text,
  }) : super(
          boxId: id,
          secretId: entityId,
          secretEntryId: secretsEntryId,
          usrId: userId,
          secretName: name,
        );

  int id;

  final String entityId;

  final String userId;

  final String secretsEntryId;

  @Unique(onConflict: ConflictStrategy.replace)
  final String name;

  final String text;
}
