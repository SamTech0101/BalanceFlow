
import 'dart:io';
import 'constants.dart';

class AppError{
  final String message;
 AppError._(this.message);

  factory AppError.storageError(){
    return AppError._(storageError);
  }
  factory AppError.customError(String errorMessage){
    return AppError._(errorMessage);
  }
  factory AppError.exception(Exception originalException) {
    if (originalException is IOException) {
      return AppError._(networkError);
  } else {
      return AppError._(unexpectedError);
  }
}
}
