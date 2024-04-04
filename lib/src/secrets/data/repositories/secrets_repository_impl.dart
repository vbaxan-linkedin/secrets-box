import 'package:secrets_box/src/core/domain/entities/index.dart';
import 'package:secrets_box/src/core/errors/exceptions.dart';
import 'package:secrets_box/src/core/errors/failure.dart';
import 'package:secrets_box/src/core/extensions/index.dart';
import 'package:secrets_box/src/core/utils/typedef.dart';
import 'package:secrets_box/src/secrets/data/datasources/index.dart';
import 'package:secrets_box/src/secrets/data/models/index.dart';
import 'package:secrets_box/src/secrets/domain/entities/index.dart';
import 'package:secrets_box/src/secrets/domain/repository/secrets_repository.dart';

final class SecretsBoxRepositoryImpl implements SecretsRepository {
  const SecretsBoxRepositoryImpl(this._dataSource);

  final SecretsBoxDataSource _dataSource;

  @override
  ResultFuture<int> createSecretsEntry({
    required String secretsEntryId,
    required String userId,
    required String title,
    required List<SecretsCategory> categories,
    required List<Secret<dynamic>> secrets,
  }) async {
    try {
      final List<String> secretIds = <String>[];
      for (final Secret<dynamic> secret in secrets) {
        Result<int>? idResult;
        if (secret is TextSecret) {
          idResult = await createSimpleTextSecret(
            secretId: secret.secretId,
            userId: userId,
            name: secret.name,
            text: secret.value,
          );
        } else if (secret is PasswordSecret) {
          idResult = await createPasswordTextSecret(
            secretId: secret.secretId,
            userId: userId,
            name: secret.name,
            password: secret.value,
          );
        }
        if (idResult?.extractSuccess().data != null) {
          secretIds.add(secret.secretId);
        }
      }
      final int result = await _dataSource.createSecretsEntry(
        secretsEntryId: secretsEntryId,
        userId: userId,
        title: title,
        categoryIds: categories.map((SecretsCategory category) {
          return category.categoryId;
        }).toFixedNonNullableList(),
        secretIds: secretIds,
      );
      return SuccessResult<int>(data: result);
    } on DatabaseException catch (e) {
      return ErrorResult<int>(failure: DatabaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> createSecretsCategory({
    required String categoryId,
    required String userId,
    required String name,
  }) async {
    try {
      final int result = await _dataSource.createSecretsCategory(
        categoryId: categoryId,
        userId: userId,
        name: name,
      );
      return SuccessResult<int>(data: result);
    } on DatabaseException catch (e) {
      return ErrorResult<int>(failure: DatabaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> createPasswordTextSecret({
    required String secretId,
    required String userId,
    required String name,
    required Password? password,
  }) async {
    try {
      final int result = await _dataSource.createPasswordTextSecret(
        secretId: secretId,
        userId: userId,
        name: name,
        password: password,
      );
      return SuccessResult<int>(data: result);
    } on DatabaseException catch (e) {
      return ErrorResult<int>(failure: DatabaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> createSimpleTextSecret({
    required String secretId,
    required String userId,
    required String name,
    required String? text,
  }) async {
    try {
      final int result = await _dataSource.createSimpleTextSecret(
        secretId: secretId,
        userId: userId,
        name: name,
        text: text,
      );
      return SuccessResult<int>(data: result);
    } on DatabaseException catch (e) {
      return ErrorResult<int>(failure: DatabaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<SecretsEntry>> fetchSecretsEntries(String userId) async {
    try {
      final List<BoxSecretsEntry> boxEntries = await _dataSource.fetchSecretsEntries(userId);
      final List<SecretsEntry> entries = boxEntries.map((BoxSecretsEntry entry) {
        return entry.toDomainModel();
      }).toFixedNonNullableList();
      return SuccessResult<List<SecretsEntry>>(data: entries);
    } on DatabaseException catch (e) {
      return ErrorResult<List<SecretsEntry>>(failure: DatabaseFailure.fromException(e));
    }
  }
}
