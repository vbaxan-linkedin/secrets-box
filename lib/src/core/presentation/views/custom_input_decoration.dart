part of core_views;

InputDecoration customInputDecoration({
  String? labelText,
  TextStyle? labelStyle,
  String? hintText,
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