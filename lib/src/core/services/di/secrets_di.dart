part of di;

extension SecretsDi on GetIt {
  void initSecrets() {
    this
      ..registerFactory(() {
        return SecretsBloc(
          fetchSecretsEntries: sl(),
        );
      })
      ..registerFactory(() => FetchSecretsEntries(sl()))
      ..registerFactory<SecretsRepository>(() => SecretsBoxRepositoryImpl(sl()))
      ..registerFactory<SecretsBoxDataSource>(() {
        final ObjectBox objectBox = sl<ObjectBox>();
        return SecretsBoxDataSourceImpl(
          secretsBox: objectBox.secretsBox,
          secretsCategoriesBox: objectBox.secretsCategoriesBox,
          secretsEntriesBox: objectBox.secretsEntriesBox,
          conditions: sl(),
        );
      })
      ..registerFactory<SecretsEntriesBoxQueryConditions>(() {
        return SecretsEntriesBoxQueryConditionsImpl();
      });
  }
}
