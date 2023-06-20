import 'package:cuteshrew/data/shrew_exception.dart';
import 'package:dio/dio.dart';

class NetworkResult<T> {
  NetworkResult._();

  bool isSuccess() => this is Success;

  bool isFailure() => this is Failure;

  Future<void> onAction({
    Function(T value)? onSuccess,
    Function(ShrewException e)? onFailure,
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

  NetworkResult<T> onFailure(Function(ShrewException e) action) {
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

  factory NetworkResult.failure(ShrewException e) = Failure;
}

class Success<T> extends NetworkResult<T> {
  final T value;

  Success(this.value) : super._();
}

class Failure<T> extends NetworkResult<T> {
  final ShrewException error;

  Failure(this.error) : super._();
}

Future<NetworkResult<T>> handleRequest<T>(
    Future<T> Function() requestFunc) async {
  try {
    return NetworkResult.success(await requestFunc());
  } catch (e, s) {
    if (e is DioException) {
      return NetworkResult.failure(
        ShrewException(
            type: ShrewExceptionType.api,
            exception: CustomDioException(e: e),
            stackTrace: e.stackTrace,
            msg: 'API Error'),
      );
    } else if (e is ShrewException) {
      return NetworkResult.failure(e);
    } else {
      return NetworkResult.failure(
        ShrewException(
          msg: 'Unknown Exception...',
          type: ShrewExceptionType.unknown,
          exception: e,
          stackTrace: s,
        ),
      );
    }
  }
}
