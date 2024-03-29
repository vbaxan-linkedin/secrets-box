part of core_services;

final class ObjectBox {
  ObjectBox._create(this.store);

  late final Store store;

  Box<BoxUser> get usersBox => store.box<BoxUser>();

  static Future<ObjectBox> create() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final Store store = await openStore(directory: p.join(dir.path, 'app-box'));
    return ObjectBox._create(store);
  }
}