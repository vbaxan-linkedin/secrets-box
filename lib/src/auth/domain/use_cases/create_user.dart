part of auth_use_cases;

class CreateUser implements UseCaseWithParams<void, CreateUserParams> {
  const CreateUser(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<int> call(CreateUserParams params) {
    return _authRepository.createUser(
      uuId: params.uuId,
      username: params.username,
      passwordHash: params.passwordHash,
      salt: params.salt,
    );
  }
}

class CreateUserParams extends Equatable {
  const CreateUserParams({
    required this.uuId,
    required this.username,
    required this.passwordHash,
    required this.salt,
  });

  const CreateUserParams.empty()
      : this(
          uuId: '',
          username: '',
          passwordHash: '',
          salt: '',
        );

  final String uuId;
  final String username;
  final String passwordHash;
  final String salt;

  @override
  List<Object?> get props => <Object>[uuId, username, passwordHash, salt];
}
