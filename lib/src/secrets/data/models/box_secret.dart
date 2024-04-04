part of secrets_data_models;

@Entity()
class BoxSecret<T> {
  BoxSecret({
    this.id = 0,
    required this.secretId,
    required this.userId,
    required this.name,
    this.secretType,
    this.secretData,
  });

  factory BoxSecret.text({
    required String secretId,
    required String userId,
    required String name,
    required String? text,
  }) {
    return BoxSecret<T>(
      secretId: secretId,
      userId: userId,
      name: name,
      secretType: BoxSecretType.text,
      secretData: BoxSecretData.fromData(text) as BoxSecretData<T>?,
    );
  }

  factory BoxSecret.password({
    required String secretId,
    required String userId,
    required String name,
    required Password? password,
  }) {
    return BoxSecret<T>(
      secretId: secretId,
      userId: userId,
      name: name,
      secretType: BoxSecretType.password,
      secretData: BoxSecretData.fromData(password) as BoxSecretData<T>?,
    );
  }

  int id;

  @Unique(onConflict: ConflictStrategy.replace)
  final String secretId;

  final String userId;

  final String? name;

  @Transient()
  BoxSecretType? secretType;

  String? get dbSecretType {
    return secretType?.name;
  }

  set dbSecretType(String? value) {
    if (value == null) {
      secretType = null;
    } else {
      secretType = BoxSecretType.values.firstWhereOrNull((BoxSecretType element) {
        return element.name == value;
      });
    }
  }

  @Transient()
  BoxSecretData<T>? secretData;

  String? get dbSecretData {
    return secretData?.stringValue();
  }

  set dbSecretData(String? value) {
    if (value == null) {
      secretData = null;
    } else {
      secretData = BoxSecretData.from(value, secretType) as BoxSecretData<T>?;
    }
  }
}

abstract class BoxSecretData<T> {
  const BoxSecretData(this.data);

  static BoxSecretData<dynamic> from(String value, BoxSecretType? secretType) {
    switch (secretType) {
      case BoxSecretType.text:
        return BoxSecretDataText(value);
      case BoxSecretType.password:
        return BoxSecretDataPassword(Password(value));
      case null:
        throw StateError('Secret type is null');
      default:
        throw StateError('Secret type $secretType  is unknown');
    }
  }

  static BoxSecretData<dynamic>? fromData(dynamic data) {
    if (data is String) {
      return BoxSecretDataText(data);
    } else if (data is Password) {
      return BoxSecretDataPassword(data);
    } else {
      return null;
    }
  }

  final T? data;

  String? stringValue();
}

class BoxSecretDataText extends BoxSecretData<String> {
  const BoxSecretDataText(this.text) : super(text);

  factory BoxSecretDataText.fromString(String rawValue) {
    return BoxSecretDataText(rawValue);
  }

  final String text;

  @override
  String stringValue() => text;
}

class BoxSecretDataPassword extends BoxSecretData<Password> {
  const BoxSecretDataPassword(this.password) : super(password);

  factory BoxSecretDataPassword.fromString(String rawValue) {
    return BoxSecretDataPassword(Password(rawValue));
  }

  final Password password;

  @override
  String stringValue() => password.password;
}

enum BoxSecretType { text, password }
