part of core_extensions;

extension EntityExtension<T> on T {
  R mapTo<R>(EntityTransformation<T, R> transformation) => transformation(this);

  T? takeIf(EntityProducer<bool> predicate) {
    return switch (predicate()) {
      true => this,
      _ => null,
    };
  }

  T? takeUnless(EntityProducer<bool> predicate) {
    return switch (predicate()) {
      true => null,
      _ => this,
    };
  }
}

extension NullableEntityExtension<T> on T? {
  T orElse(EntityProducer<T> orElseProducer) {
    return this ?? orElseProducer();
  }
}
