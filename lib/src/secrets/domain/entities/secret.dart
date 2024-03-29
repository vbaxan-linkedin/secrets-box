part of secrets_entities;

sealed class Secret extends Equatable {
  const Secret({
    required this.secretId,
    required this.secretsEntryId,
    required this.userId,
    required this.name,
  });

  final String secretId;
  final String secretsEntryId;
  final String userId;
  final String name;

  @override
  List<Object?> get props => <Object?>[secretId, secretsEntryId, userId, name];
}

final class SimpleTextSecret extends Secret {
  const SimpleTextSecret({
    required String secretId,
    required String secretsEntryId,
    required String userId,
    required String name,
    required this.text,
  }) : super(
          secretId: secretId,
          secretsEntryId: secretsEntryId,
          userId: userId,
          name: name,
        );

  final String text;

  @override
  List<Object?> get props => <Object?>[...super.props, text];
}

final class PasswordSecret extends Secret {
  PasswordSecret(
    BuildContext context, {
    required String secretId,
    required String secretsEntryId,
    required String userId,
    String? name,
    required this.password,
  }) : super(
          secretId: secretId,
          secretsEntryId: secretsEntryId,
          userId: userId,
          name: name ?? S.of(context).password,
        );

  final String password;

  @override
  List<Object?> get props => <Object?>[...super.props, password];
}