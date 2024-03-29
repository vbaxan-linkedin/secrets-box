part of auth_use_cases;

class FindUser implements UseCaseWithParams<User?, FindUserParams> {
  const FindUser(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<User?> call(FindUserParams params) async {
    return _authRepository.findUser(params.username);
  }
}

class FindUserParams extends Equatable {
  const FindUserParams({required this.username});

  final String username;

  @override
  List<Object?> get props => <Object?>[username];
}