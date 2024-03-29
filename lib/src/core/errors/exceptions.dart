import 'package:equatable/equatable.dart';

sealed class DatabaseException extends Equatable implements Exception {
  const DatabaseException(this.message);

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

final class DatabaseUniqueViolationException extends DatabaseException {
  const DatabaseUniqueViolationException(String message) : super(message);
}

final class DatabaseExceptionUnknown extends DatabaseException {
  const DatabaseExceptionUnknown() : super('Unknown database error has occurred.');
}