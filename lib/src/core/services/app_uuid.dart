part of core_services;

abstract interface class AppUuid {
  String generateV4Uuid();
}

final class AppUuidImpl implements AppUuid {
  const AppUuidImpl();

  @override
  String generateV4Uuid() {
    return const Uuid().v4();
  }
}