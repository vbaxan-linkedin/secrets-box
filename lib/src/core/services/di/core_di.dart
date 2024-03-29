part of di;

extension CoreDi on GetIt {
  void initCoreObjects() {
    this..registerFactory(() => HashString(utf8codec: sl(), hash: sl()))
      ..registerFactory<AppUtf8Codec>(() => const AppUtf8CodecImpl())
      ..registerFactory<AppHash>(() => const AppHashImpl())
      ..registerFactory(() => GenerateUuid(sl()))
      ..registerFactory<AppUuid>(() => const AppUuidImpl())
      ..registerFactory(() => GetNowDateTime(sl()))
      ..registerFactory<AppDateTime>(() => const AppDateTimeImpl());
  }
}