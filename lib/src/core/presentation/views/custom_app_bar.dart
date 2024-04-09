part of core_views;

final class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar._(
    this.context, {
    super.key,
    this.title,
    required this.actions,
    this.bottom,
    this.footerHeight,
    this.leading,
  });

  factory CustomAppBar.normal(
    BuildContext context, {
    Key? key,
    String? title,
    List<Widget> actions = const <Widget>[],
    Widget? leading,
  }) {
    return CustomAppBar._(
      context,
      key: key,
      title: title,
      actions: actions,
      leading: leading,
    );
  }

  factory CustomAppBar.withFooter(
    BuildContext context, {
    Key? key,
    String? title,
    List<Widget> actions = const <Widget>[],
    required PreferredSizeWidget bottom,
    double footerHeight = 75.0,
    Widget? leading,
  }) {
    return CustomAppBar._(
      context,
      key: key,
      title: title,
      actions: actions,
      bottom: bottom,
      footerHeight: footerHeight,
      leading: leading,
    );
  }

  final BuildContext context;
  final String? title;
  final Widget? leading;
  final List<Widget> actions;
  final PreferredSizeWidget? bottom;
  final double? footerHeight;

  @override
  Size get preferredSize {
    double extraHeight = MediaQuery.of(context).padding.top;
    final double? bottomH = bottom?.preferredSize.height;
    if (bottomH != null) {
      extraHeight += bottomH;
    }
    return Size.fromHeight(kToolbarHeight + extraHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppBar(
        backgroundColor: AppColors.kIndigoPrimary,
        title: title.isNullOrBlank
            ? null
            : Text(
                title.orEmpty,
                style: const TextStyle(
                  color: AppColors.kIndigo50,
                ),
              ),
        leading: leading,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: actions.map((Widget action) {
                return action;
              }).toFixedNonNullableList(),
            ),
          )
        ],
        bottom: bottom,
      ),
    );
  }
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_outlined),
      color: AppColors.kIndigo50,
      onPressed: goRouter.pop,
    );
  }
}
