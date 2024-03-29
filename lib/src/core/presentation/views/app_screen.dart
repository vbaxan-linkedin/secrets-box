part of core_views;

class AppScreen extends StatelessWidget {
  factory AppScreen.blank() {
    return const AppScreen._(
      variant: _VariantBlank(),
    );
  }

  factory AppScreen.normal({
    CustomAppBar? appBar,
    required Widget child,
    Widget? floatingActionButton,
    BottomNavigationBar? bottomNavigationBar,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
  }) {
    return AppScreen._(
      variant: _VariantNormal(
          appBar: appBar,
          child: child,
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomNavigationBar,
          padding: padding),
    );
  }

  factory AppScreen.loadingWithoutAppBar() {
    return const AppScreen._(
      variant: _VariantLoadingWithoutAppBar(),
    );
  }

  factory AppScreen.loadingWithAppBar({
    required CustomAppBar appBar,
  }) {
    return AppScreen._(
      variant: _VariantLoadingWithAppBar(appBar),
    );
  }

  const AppScreen._({
    Key? key,
    this.variant = const _VariantBlank(),
  }) : super(key: key);

  final _Variant variant;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: switch (variant) {
        _VariantNormal(appBar: final CustomAppBar? appBar) => appBar,
        _VariantLoadingWithAppBar(appBar: final CustomAppBar appBar) => appBar,
        _ => null,
      },
      floatingActionButton: switch (variant) {
        _VariantNormal(floatingActionButton: final Widget? button) => button,
        _ => null,
      },
      body: switch (variant) {
        _VariantBlank() => const SizedBox.shrink(),
        _VariantNormal(
          child: final Widget child,
          padding: final EdgeInsetsGeometry padding,
        ) =>
          Padding(
            padding: padding,
            child: child,
          ),
        _VariantLoadingWithoutAppBar() || _VariantLoadingWithAppBar() => const Center(
            child: CircularProgressIndicator(),
          ),
      },
      bottomNavigationBar: switch (variant) {
        _VariantNormal(bottomNavigationBar: final BottomNavigationBar? bar) => bar,
        _ => null,
      },
    );
  }
}

sealed class _Variant {
  const _Variant({this.appBar});

  final CustomAppBar? appBar;
}

final class _VariantBlank extends _Variant {
  const _VariantBlank() : super();
}

final class _VariantNormal extends _Variant {
  _VariantNormal({
    CustomAppBar? appBar,
    required this.child,
    this.bottomNavigationBar,
    this.floatingActionButton,
    required this.padding,
  }) : super(appBar: appBar);

  final Widget child;
  final Widget? floatingActionButton;
  final BottomNavigationBar? bottomNavigationBar;
  final EdgeInsetsGeometry padding;
}

final class _VariantLoadingWithoutAppBar extends _Variant {
  const _VariantLoadingWithoutAppBar() : super();
}

final class _VariantLoadingWithAppBar extends _Variant {
  const _VariantLoadingWithAppBar(CustomAppBar appBar) : super(appBar: appBar);
}
