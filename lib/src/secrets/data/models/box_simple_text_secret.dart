part of secrets_data_models;

// @Entity()
// class BoxTextSecret extends BoxSecret<String> {
//   BoxTextSecret({
//     this.id = 0,
//     required this.entityId,
//     required this.userId,
//     required this.name,
//     required this.text,
//   }) : super(
//           boxId: id,
//           secretId: entityId,
//           usrId: userId,
//           secretName: name,
//           value: text,
//         );
//
//   int id;
//
//   final String entityId;
//
//   final String userId;
//
//   @Unique(onConflict: ConflictStrategy.replace)
//   final String name;
//
//   final String? text;
// }
