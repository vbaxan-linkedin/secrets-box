part of secrets_entities;

sealed class Secret<T> extends Equatable {
  const Secret({
    required this.secretId,
    required this.name,
    required this.value,
  });

  final String secretId;
  final String name;
  final T? value;

  @override
  List<Object?> get props => <Object?>[secretId, name];
}

final class TextSecret extends Secret<String> {
  const TextSecret({
    required String secretId,
    required String name,
    required this.text,
  }) : super(
          secretId: secretId,
          name: name,
          value: text,
        );

  final String? text;

  @override
  List<Object?> get props => <Object?>[...super.props, text];
}

final class PasswordSecret extends Secret<Password> {
  PasswordSecret(
    BuildContext context, {
    required String secretId,
    String? name,
    required this.password,
  }) : super(
          secretId: secretId,
          name: name ?? S.of(context).password,
          value: password,
        );

  final Password? password;

  @override
  List<Object?> get props => <Object?>[...super.props, password];
}
