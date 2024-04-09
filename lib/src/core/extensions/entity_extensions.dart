part of core_extensions;

extension EntityExtension<T> on T {
  R mapTo<R>(EntityTransformation<T, R> transformation) => transformation(this);

  T? takeIf(Predicate<T> predicate) {
    return switch (predicate(this)) {
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

  R? whenNullOrElse<R>({
    required EntityProducer<R?> whenNull,
    required EntityTransformation<T, R?> orElse,
  }) {
    if (this == null) {
      return whenNull();
    } else {
      return orElse(this as T);
    }
  }
}
