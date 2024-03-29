import 'package:secrets_box/src/core/utils/typedef.dart';
import 'package:secrets_box/src/secrets/domain/entities/index.dart';

abstract interface class SecretsRepository {
  const SecretsRepository();

  ResultFuture<int> createSecretsEntry({
    required String secretsEntryId,
    required String userId,
    required String? categoryId,
    required String title,
  });

  ResultFuture<int> createSecretsCategory({
    required String categoryId,
    required String userId,
    required String name,
  });

  ResultFuture<int> createSimpleTextSecret({
    required String secretId,
    required String secretsEntryId,
    required String userId,
    required String name,
    required String text,
  });

  ResultFuture<int> createPasswordTextSecret({
    required String secretId,
    required String secretsEntryId,
    required String userId,
    required String name,
    required String password,
  });

  ResultFuture<List<SecretsEntry>> fetchSecretsEntries(String userId);
}
