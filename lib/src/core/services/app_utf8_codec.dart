part of core_services;

abstract interface class AppUtf8Codec {
  Uint8List encode(String string);
}

final class AppUtf8CodecImpl implements AppUtf8Codec {
  const AppUtf8CodecImpl();

  @override
  Uint8List encode(String string) {
    return utf8.encode(string);
  }
}