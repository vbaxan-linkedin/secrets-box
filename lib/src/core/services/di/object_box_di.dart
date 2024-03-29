part of di;

extension ObjectBoxDi on GetIt {
  void initObjectBox(ObjectBox objectBox) {
    registerLazySingleton<ObjectBox>(() => objectBox);
  }
}