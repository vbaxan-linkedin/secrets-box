part of secrets_datasources;

final class SecretsBoxDataSourceImpl implements SecretsBoxDataSource {
  const SecretsBoxDataSourceImpl({
    required this.secretsBox,
    required this.secretsCategoriesBox,
    required this.secretsEntriesBox,
    required this.conditions,
  });

  final Box<BoxSecret> secretsBox;
  final Box<BoxSecretsCategory> secretsCategoriesBox;
  final Box<BoxSecretsEntry> secretsEntriesBox;
  final SecretsEntriesBoxQueryConditions conditions;

  @override
  Future<int> createSecretsEntry({
    required String secretsEntryId,
    String? categoryId,
    required String userId,
    required String title,
  }) async {
    try {
      return secretsEntriesBox.put(
        BoxSecretsEntry(
          secretsEntryId: secretsEntryId,
          userId: userId,
          categoryId: categoryId,
          title: title,
        ),
        mode: PutMode.insert,
      );
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }

  @override
  Future<int> createSecretsCategory({
    required String categoryId,
    required String userId,
    required String name,
  }) async {
    try {
      return secretsCategoriesBox.put(
        BoxSecretsCategory(
          categoryId: categoryId,
          userId: userId,
          name: name
        ),
        mode: PutMode.insert,
      );
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }

  @override
  Future<int> createPasswordTextSecret({
    required String secretId,
    required String secretsEntryId,
    required String userId,
    required String name,
    required String password,
  }) async {
    try {
      return secretsBox.put(
        BoxPasswordSecret(
          entityId: secretId,
          secretsEntryId: secretsEntryId,
          userId: userId,
          name: name,
          password: password,
        ),
        mode: PutMode.insert,
      );
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }

  @override
  Future<int> createSimpleTextSecret({
    required String secretId,
    required String secretsEntryId,
    required String userId,
    required String name,
    required String text,
  }) async {
    try {
      return secretsBox.put(
        BoxSimpleTextSecret(
          entityId: secretId,
          secretsEntryId: secretsEntryId,
          userId: userId,
          name: name,
          text: text,
        ),
        mode: PutMode.insert,
      );
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }

  @override
  Future<List<BoxSecretsEntry>> fetchSecretsEntries(String userId) async {
    try {
      final Query<BoxSecretsEntry?> query = secretsEntriesBox.query(conditions.userIdEquals(userId)).build();
      final List<BoxSecretsEntry> results = query.find().whereType<BoxSecretsEntry>().toFixedNonNullableList();
      query.close();
      return results;
    } catch (e) {
      throw const DatabaseExceptionUnknown();
    }
  }
}
