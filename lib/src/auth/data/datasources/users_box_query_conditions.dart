part of auth_datasources;

abstract interface class UsersBoxQueryConditions {
  Condition<BoxUser> userNameEquals(String username);
}

final class UsersBoxQueryConditionsImpl implements UsersBoxQueryConditions {
  @override
  Condition<BoxUser> userNameEquals(String username) {
    return BoxUser_.username.equals(username);
  }
}