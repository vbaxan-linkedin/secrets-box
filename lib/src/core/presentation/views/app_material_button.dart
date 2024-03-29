part of core_views;

class AppMaterialButton extends StatelessWidget {
  const AppMaterialButton({
    super.key,
    required this.text,
    this.onTap,
  });

  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.kIndigoPrimary,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.kIndigo50,
        ),
      ),
    );
  }
}
