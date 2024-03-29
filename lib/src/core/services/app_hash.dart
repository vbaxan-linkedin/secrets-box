part of core_services;

abstract interface class AppHash {
  Digest convert(List<int> input);
}

final class AppHashImpl implements AppHash {
  const AppHashImpl();

  @override
  Digest convert(List<int> input) {
    return sha256.convert(input);
  }
}