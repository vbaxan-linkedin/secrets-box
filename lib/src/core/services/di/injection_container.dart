part of di;

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final ObjectBox objectBox = await ObjectBox.create();
  sl
    ..initObjectBox(objectBox)
    ..initCoreObjects()
    ..initAuth();
}