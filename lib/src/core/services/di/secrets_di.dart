part of di;

extension SecretsDi on GetIt {
  void initSecrets(BuildContext context) {
    final UserLoggedIn? userLoggedIn = context.read<AuthBloc>().concreteState<UserLoggedIn>();
    if (userLoggedIn == null) {
      throw StateError('User is not logged in, but accessing secrets? WTF!');
    }
    this
      ..registerFactory(() {
        return SecretsBloc(
          userId: userLoggedIn.userId,
          fetchSecretsEntries: sl(),
          createSecretsEntry: sl(),
          appUuid: sl(),
        );
      })
      ..registerFactory(() => FetchSecretsEntries(sl()))
      ..registerFactory(() => CreateSecretsEntry(sl()))
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
