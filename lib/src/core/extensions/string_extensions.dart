extension StringExtension on String? {
  bool get isNullOrBlank {
    return this == null || this?.trim().isEmpty == true;
  }

  String get orEmpty => this ?? '';
}