import 'dart:io';

import 'package:cuteshrew/2_data/custom_exception.dart';

class AsyncResult<T> {
  AsyncResult._();

  bool isSuccess() => this is Success;

  bool isFailure() => this is Failure;

  Future<void> onAction({
    Function(T value)? onSuccess,
    Function(CustomException e)? onError,
  }) async {
    if (isSuccess()) {
      await onSuccess?.call((this as Success).value);
    } else {
      await onError?.call((this as Failure).exception);
    }
  }

  AsyncResult<T> onSuccess(Function(T value) action) {
    if (isSuccess()) action((this as Success).value);
    return this;
  }

  AsyncResult<T> onFailure(Function(CustomException e) action) {
    if (isFailure()) action((this as Failure).exception);
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
      throw (this as Failure).exception;
    }
  }

  T getOrElse(T Function(Object e) onFailure) {
    if (isSuccess()) {
      return (this as Success).value;
    } else {
      return onFailure((this as Failure).exception);
    }
  }

  factory AsyncResult.success(T value) = Success;

  factory AsyncResult.failure(CustomException e) = Failure;
}

class Success<T> extends AsyncResult<T> {
  final T value;

  Success(this.value) : super._();
}

class Failure<T> extends AsyncResult<T> {
  final CustomException exception;

  Failure(this.exception) : super._();
}

Future<AsyncResult<T>> handleRequest<T>(
    Future<T> Function() requestFunc) async {
  try {
    return AsyncResult.success(await requestFunc());
  } catch (e, s) {
    if (e is Error) {
      return AsyncResult.failure(
        CustomException(
          msg: '에러',
          exception: e,
          stackTrace: s,
          type: CustomExceptionType.error,
        ),
      );
    } else if (e is TypeError) {
      return AsyncResult.failure(
        CustomException(
          msg: '타입 에러',
          exception: e,
          stackTrace: s,
          type: CustomExceptionType.type,
        ),
      );
    } else if (e is HttpException) {
      return AsyncResult.failure(
        CustomException(
          msg: 'API 에러',
          exception: e,
          stackTrace: s,
          type: CustomExceptionType.api,
        ),
      );
    } else {
      return AsyncResult.failure(
        CustomException(
          msg: '알 수 없는 에러',
          exception: e,
          stackTrace: s,
          type: CustomExceptionType.unknown,
        ),
      );
    }
  }
}
