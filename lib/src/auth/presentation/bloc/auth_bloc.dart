import 'package:bloc/bloc.dart';
import 'package:secrets_box/src/auth/domain/entities/index.dart';
import 'package:secrets_box/src/auth/domain/use_cases/index.dart';
import 'package:secrets_box/src/auth/presentation/bloc/events/index.dart';
import 'package:secrets_box/src/auth/presentation/bloc/states/index.dart';
import 'package:secrets_box/src/core/domain/entities/index.dart';
import 'package:secrets_box/src/core/domain/use_case/index.dart';
import 'package:secrets_box/src/core/errors/failure.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required GetHasUsers getHasUsers,
    required CreateUser createUser,
    required HashString hashString,
    required GenerateUuid generateUuid,
    required GetNowDateTime getNowDateTime,
    required FindUser findUser,
  })  : _getHasUsers = getHasUsers,
        _createUser = createUser,
        _hashString = hashString,
        _generateUuid = generateUuid,
        _getNowDateTime = getNowDateTime,
        _findUser = findUser,
        super(const AuthInitial()) {
    on<CreateUserEvent>(handleCreateUser);
    on<HasUsersEvent>(handleGetHasUsers);
    on<LoginEvent>(handleLogin);
  }

  final GetHasUsers _getHasUsers;
  final CreateUser _createUser;
  final HashString _hashString;
  final GenerateUuid _generateUuid;
  final GetNowDateTime _getNowDateTime;
  final FindUser _findUser;

  Future<void> handleCreateUser(CreateUserEvent event, Emitter<AuthState> emitter) async {
    emitter(const CreatingUser());
    try {
      final Result<DateTime> nowResult = await _getNowDateTime();
      final DateTime now = nowResult.extractSuccess().data;

      final Result<String> saltResult = await _hashString(
        HashStringParams(now.toString()),
      );
      final String salt = saltResult.extractSuccess().data;

      final Result<String> uuidResult = await _generateUuid();
      final String uuid = uuidResult.extractSuccess().data;

      final Result<String> passwordHashResult = await _hashString(
        HashStringParams(salt + event.password),
      );
      final String passwordHash = passwordHashResult.extractSuccess().data;

      final Result<int> createUserIdResult = await _createUser(
        CreateUserParams(
          uuId: uuid,
          username: event.username,
          passwordHash: passwordHash,
          salt: salt,
        ),
      );
      createUserIdResult.extractSuccess();
      emitter(const UserCreated());
    } on Failure catch (failure) {
      emitter(AuthError(failure.message));
    }
  }

  Future<void> handleGetHasUsers(HasUsersEvent event, Emitter<AuthState> emitter) async {
    emitter(const FetchingHasUsers());
    try {
      final Result<bool> hasUsersResult = await _getHasUsers();
      final bool hasUsers = hasUsersResult.extractSuccess().data;
      emitter(HasUsersFetched(hasUsers));
    } on Failure catch (failure) {
      emitter(AuthError(failure.message));
    }
  }

  Future<void> handleLogin(LoginEvent event, Emitter<AuthState> emitter) async {
    emitter(const LoggingInUser());
    try {
      final Result<User?> findUserResult = await _findUser(
        FindUserParams(username: event.username),
      );
      final User? user = findUserResult.extractSuccess().data;
      const String message = "Username or password doesn't match";
      if (user == null) {
        throw const Failure(message: message);
      } else {
        final Result<String> passwordHashResult = await _hashString(
          HashStringParams(user.salt + event.password),
        );
        final String passwordHash = passwordHashResult.extractSuccess().data;
        if (passwordHash == user.passwordHash) {
          emitter(UserLoggedIn(userId: user.uuId));
        } else {
          throw const Failure(message: message);
        }
      }
    } on Failure catch (failure) {
      emitter(AuthError(failure.message));
    }
  }
}
