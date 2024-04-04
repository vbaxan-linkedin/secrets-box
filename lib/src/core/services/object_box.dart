part of core_services;

final class ObjectBox {
  ObjectBox._create(this.store);

  late final Store store;

  Box<BoxUser> get usersBox => store.box<BoxUser>();

  Box<BoxSecret<dynamic>> get secretsBox => store.box<BoxSecret<dynamic>>();

  Box<BoxSecretsCategory> get secretsCategoriesBox => store.box<BoxSecretsCategory>();

  Box<BoxSecretsEntry> get secretsEntriesBox => store.box<BoxSecretsEntry>();

  static Future<ObjectBox> create() async {
    final Directory dir = await getApplicationDocumentsDirectory();
    final Store store = await openStore(directory: p.join(dir.path, 'app-box'));
    return ObjectBox._create(store);
  }
}