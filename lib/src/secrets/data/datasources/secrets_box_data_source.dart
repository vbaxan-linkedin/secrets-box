part of secrets_datasources;

abstract interface class SecretsBoxDataSource {
  Future<int> createSecretsEntry({
    required String secretsEntryId,
    required String userId,
    required String title,
    required List<String> categoryIds,
    required List<String> secretIds,
  });

  Future<int> createSecretsCategory({
    required String categoryId,
    required String userId,
    required String name,
  });

  Future<int> createSimpleTextSecret({
    required String secretId,
    required String userId,
    required String name,
    required String? text,
  });

  Future<int> createPasswordTextSecret({
    required String secretId,
    required String userId,
    required String name,
    required Password? password,
  });

  Future<List<BoxSecretsEntry>> fetchSecretsEntries(String userId);
}
