part of secrets_data_models;

// @Entity()
// class BoxPasswordSecret extends BoxSecret<Password> {
//   BoxPasswordSecret({
//     this.id = 0,
//     required this.entityId,
//     required this.userId,
//     required this.name,
//     this.password,
//   }) : super(
//           boxId: id,
//           secretId: entityId,
//           usrId: userId,
//           secretName: name,
//           value: password,
//         );
//
//   int id;
//
//   @Unique(onConflict: ConflictStrategy.replace)
//   final String entityId;
//
//   final String userId;
//
//   final String? name;
//
//   @Transient()
//   Password? password;
//
//   String? get dbPassword {
//     return password?.password;
//   }
//   set dbPassword(String? value) {
//     if (value == null) {
//       password = null;
//     } else {
//       password = Password(value);
//     }
//   }
// }
