part of core_services;

abstract interface class AppDateTime {
  DateTime now();
}

final class AppDateTimeImpl implements AppDateTime {
  const AppDateTimeImpl();

  @override
  DateTime now() {
    return DateTime.now();
  }
}