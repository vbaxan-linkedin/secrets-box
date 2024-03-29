part of auth_states;

final class FetchingHasUsers extends AuthState {
  const FetchingHasUsers();
}

final class HasUsersFetched extends AuthState {
  const HasUsersFetched(this.hasUsers);

  final bool hasUsers;

  @override
  List<Object> get props => <Object>[hasUsers];
}