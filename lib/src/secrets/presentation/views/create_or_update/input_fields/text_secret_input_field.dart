part of secret_input_fields;

final class TextSecretInputField extends SecretInputField<TextSecret> {
  TextSecretInputField({
    super.key,
    required super.secret,
    this.controller,
    this.hintText,
  }) : super(
          formField: TextFormField(
            initialValue: secret.value,
            controller: controller,
            decoration: customInputDecoration(
              hintText: hintText,
            ),
            validator: null,
          ),
        );

  final TextEditingController? controller;
  final String? hintText;
}
