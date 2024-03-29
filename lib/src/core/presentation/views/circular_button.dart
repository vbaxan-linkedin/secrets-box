part of core_views;

class CircularButton extends StatelessWidget {
  const CircularButton._({
    super.key,
    this.icon,
    this.iconColor,
    required this.width,
    required this.height,
    this.color,
    this.onTap,
  });

  factory CircularButton.icon({
    Key? key,
    required IconData icon,
    required Color iconColor,
    double width = 24.0,
    double height = 24.0,
    Color? color,
    VoidCallback? onTap,
  }) {
    return CircularButton._(
      key: key,
      icon: icon,
      iconColor: iconColor,
      width: width,
      height: height,
      color: color,
      onTap: onTap,
    );
  }

  final IconData? icon;
  final Color? iconColor;
  final double width;
  final double height;
  final Color? color;
  final VoidCallback? onTap;

  Widget get _child {
    if (icon != null) {
      return Icon(
        icon,
        color: iconColor,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.transparent,
        ),
        child: _child,
      ),
    );
  }
}
