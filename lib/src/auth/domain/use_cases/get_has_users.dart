part of auth_use_cases;

class GetHasUsers implements UseCaseWithoutParams<bool>{
  const GetHasUsers(this._authRepository);

  final AuthRepository _authRepository;

  @override
  ResultFuture<bool> call() => _authRepository.hasUsers();
}