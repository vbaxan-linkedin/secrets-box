part of core_views;

InputDecoration customInputDecoration({
  required String labelText,
  TextStyle? labelStyle,
  required String hintText,
  TextStyle? hintStyle,
  String? errorText,
  InputBorder? border = const OutlineInputBorder(),
}) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: labelStyle,
    hintText: hintText,
    hintStyle: hintStyle,
    enabledBorder: border,
    focusedBorder: border,
    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
    errorText: errorText
  );
}