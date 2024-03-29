part of core_extensions;

extension NullableIterableExtension<T> on Iterable<T>? {
  List<T> toFixedNonNullableList() => this?.toList(growable: false) ?? <T>[];

  Set<T> toNonNullableSet() => this?.toSet() ?? <T>{};

  bool get isNullOrEmpty => this?.isEmpty ?? true;

  T? get firstOrNull {
    if (isNullOrEmpty) {
      return null;
    }
    return this!.first;
  }

  T? get lastOrNull {
    if (isNullOrEmpty) {
      return null;
    }
    return this!.last;
  }

  bool containsAll(Iterable<T> sublist) {
    return this != null && sublist.whereNot((T element) => this!.contains(element)).isEmpty;
  }

  bool containsAnyFrom(Iterable<T> other) {
    return this != null && other.any((T element) => this!.contains(element));
  }

  Map<K, T>? toMap<K>({required EntityTransformation<T, K> keyProducer}) {
    return this?.mapTo((Iterable<T> iterable) {
      return <K, T>{for (final T element in iterable) keyProducer(element): element};
    });
  }
}