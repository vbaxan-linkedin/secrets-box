part of secrets_data_models;

abstract class BoxSecret {
  BoxSecret({
    required this.boxId,
    required this.secretId,
    required this.secretEntryId,
    required this.usrId,
    required this.secretName,
  });

  final int boxId;
  final String secretId;
  final String secretEntryId;
  final String usrId;
  String? secretName;
}
