part of auth_datasources;

extension UsersBoxExtension on Box<BoxUser> {
  bool isNotEmpty() => !isEmpty();
}
