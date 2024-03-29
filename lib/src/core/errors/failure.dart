import 'package:equatable/equatable.dart';
import 'package:secrets_box/src/core/errors/exceptions.dart';

base class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => <Object>[message];
}

final class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message});

  factory DatabaseFailure.fromException(DatabaseException e) {
    return DatabaseFailure(message: e.message);
  }
}

final class HashStringFailure extends Failure {
  const HashStringFailure({
    required this.stringToHash,
  }) : super(message: 'Failed to hash $stringToHash');

  final String stringToHash;

  @override
  List<Object?> get props => super.props + <String>[stringToHash];
}

final class UuidFailure extends Failure {
  const UuidFailure() : super(message: 'Failed to generate uuid');
}

final class NowDateTimeFailure extends Failure {
  const NowDateTimeFailure() : super(message: 'Failed to get now date time');
}

final class UnknownFailure extends Failure {
  const UnknownFailure() : super(message: 'Unknown failure');
}

