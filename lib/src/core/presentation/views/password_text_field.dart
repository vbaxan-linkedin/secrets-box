part of core_views;

final class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
  });

  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: customInputDecoration(
        labelText: widget.labelText ?? S.of(context).password,
        hintText: widget.hintText ?? S.of(context).password,
      ).copyWith(
        suffixIcon: IconButton(
          icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() => _showPassword = !_showPassword);
          },
        ),
      ),
      obscureText: !_showPassword,
    );
  }
}
