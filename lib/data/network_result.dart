class NetworkResult<T> {
  NetworkResult._();

  bool isSuccess() => this is Success;

  bool isFailure() => this is Failure;

  Future<void> onAction({
    Function(T value)? onSuccess,
    Function(Exception e)? onFailure,
  }) async {
    if (isSuccess()) {
      await onSuccess?.call((this as Success).value);
    } else {
      await onFailure?.call((this as Failure).error);
    }
  }

  NetworkResult<T> onSuccess(Function(T value) action) {
    if (isSuccess()) action((this as Success).value);
    return this;
  }

  NetworkResult<T> onFailure(Function(Exception e) action) {
    if (isFailure()) action((this as Failure).error);
    return this;
  }

  T? getOrNull() {
    if (isSuccess()) return (this as Success).value;
    return null;
  }

  T getOrThrow() {
    if (isSuccess()) {
      return (this as Success).value;
    } else {
      throw (this as Failure).error;
    }
  }

  T getOrElse(T Function(Object e) onFailure) {
    if (isSuccess()) {
      return (this as Success).value;
    } else {
      return onFailure((this as Failure).error);
    }
  }

  factory NetworkResult.success(T value) = Success;

  factory NetworkResult.failure(Exception e) = Failure;
}

class Success<T> extends NetworkResult<T> {
  final T value;

  Success(this.value) : super._();
}

class Failure<T> extends NetworkResult<T> {
  final Exception error;

  Failure(this.error) : super._();
}
