
import 'dart:io';
import 'constants.dart';

class AppError{
final String message;
  AppError(this.message);

  factory AppError.storageError(){
    return AppError(storageError);
  }
  factory AppError.transactionError(){
    return AppError(generalError);
  }
  factory AppError.exception(Exception originalException) {
    if (originalException is IOException) {
      return AppError(networkError);
  } else {
      return AppError(unexpectedError);
  }
}
}