part of core_entities;

sealed class Result<T> {
  const Result();

  SuccessResult<T> extractSuccess() {
    if (this is SuccessResult<T>) {
      final SuccessResult<T>? successResult = this as SuccessResult<T>?;
      if (successResult != null) {
        return successResult;
      }
    } else if (this is ErrorResult<T>) {
      throw (this as ErrorResult<T>).failure;
    }
    throw const UnknownFailure();
  }
}

final class SuccessResult<T> extends Result<T> {
  const SuccessResult({required this.data});

  final T data;
}

final class ErrorResult<T> extends Result<T> {
  const ErrorResult({required this.failure});

  final Failure failure;
}
