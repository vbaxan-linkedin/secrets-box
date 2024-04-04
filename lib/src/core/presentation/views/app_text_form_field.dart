part of core_views;

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.name,
    this.hintText,
    this.value,
    this.validator,
    this.controller,
  });

  final String name;
  final String? hintText;
  final String? value;
  final EntityTransformation<String?, String?>? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SeparatedFlex<Widget>.widget(
      items: <Widget>[
        Text(
          name,
        ),
        TextFormField(
          initialValue: value,
          controller: controller,
          decoration: customInputDecoration(
            hintText: hintText,
          ),
          validator: validator,
        ),
      ],
      spacing: 6.0,
    );
  }
}
