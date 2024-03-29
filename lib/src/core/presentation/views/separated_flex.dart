part of core_views;

typedef SeparatedFlexCustomSeparatorBuilder = Widget? Function(
  BuildContext context, {
  required int itemsCount,
  required int index,
});

final class SeparatedFlex<T> extends StatelessWidget {
  const SeparatedFlex({
    super.key,
    required this.items,
    this.direction = Axis.vertical,
    this.mainAxisSize,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.spacing = 16.0,
    this.isExpanded = false,
    required this.itemBuilder,
    this.customSeparatorBuilder,
  });

  factory SeparatedFlex.widget({
    required List<T> items,
    Axis direction = Axis.vertical,
    MainAxisSize? mainAxisSize,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    double spacing = 16.0,
    bool isExpanded = true,
    SeparatedFlexCustomSeparatorBuilder? customSeparatorBuilder,
  }) {
    return SeparatedFlex<T>(
      items: items,
      direction: direction,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      spacing: spacing,
      isExpanded: isExpanded,
      itemBuilder: (BuildContext context, T widget, int index) {
        return switch (widget) {
          final Widget widget => widget,
          _ => throw 'Item $widget is not a widget',
        };
      },
      customSeparatorBuilder: customSeparatorBuilder,
    );
  }

  final List<T> items;
  final Axis direction;
  final MainAxisSize? mainAxisSize;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final double spacing;
  final bool isExpanded;
  final EntityWidgetBuilderIndexed<T> itemBuilder;
  final SeparatedFlexCustomSeparatorBuilder? customSeparatorBuilder;

  List<Widget> _children(BuildContext context) {
    return List<Widget>.generate(items.length * 2 - 1, (int index) {
      final int itemIndex = index ~/ 2;
      if (index % 2 == 0) {
        return itemBuilder(context, items[itemIndex], itemIndex);
      } else {
        final SizedBox defaultSeparator = switch (direction) {
          Axis.horizontal => SizedBox(width: spacing),
          _ => SizedBox(height: spacing),
        };
        return customSeparatorBuilder?.mapTo((SeparatedFlexCustomSeparatorBuilder customSeparatorBuilder) {
              return customSeparatorBuilder(
                context,
                itemsCount: items.length,
                index: itemIndex + 1,
              );
            }) ??
            defaultSeparator;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return switch (items) {
      [] => const SizedBox.shrink(),
      _ => Flex(
          direction: direction,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment.orElse(() {
            return switch (direction) {
              Axis.vertical => CrossAxisAlignment.start,
              _ => CrossAxisAlignment.center,
            };
          }),
          children: switch (isExpanded) {
            true => _children(context).mapIndexed((int index, Widget child) {
                return switch (index % 2) {
                  0 => Expanded(child: child),
                  _ => child,
                };
              }).toFixedNonNullableList(),
            false => _children(context),
          },
        ),
    };
  }
}
