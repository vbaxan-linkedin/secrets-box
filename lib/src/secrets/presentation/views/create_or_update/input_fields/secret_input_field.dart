part of secret_input_fields;

abstract class SecretInputField<T extends Secret<dynamic>> extends StatelessWidget {
  const SecretInputField({
    super.key,
    required this.secret,
    required this.formField,
  });

  final T secret;
  final Widget formField;

  @override
  Widget build(BuildContext context) {
    return SeparatedFlex<Widget>.widget(
      items: <Widget>[
        Text(
          secret.name,
        ),
        formField,
      ],
      spacing: 6.0,
    );
  }
}
