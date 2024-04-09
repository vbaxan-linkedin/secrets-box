part of core_presentation_entitites;

final class NewStateValue<T> extends Equatable {
  const NewStateValue(
    this.value, {
    this.forceApply = false,
  });

  final T? value;
  final bool forceApply;

  @override
  List<Object?> get props => <Object?>[value, forceApply];
}

extension NullableNewStateValueExtension<T> on NewStateValue<T>? {
  T? valueOr(T? or) {
    return whenNullOrElse(
      whenNull: () => or,
      orElse: (NewStateValue<T> newStateValue) {
        return newStateValue.value.takeIf((T? value) {
          return value != null || newStateValue.forceApply;
        });
      }
    );
  }
}
