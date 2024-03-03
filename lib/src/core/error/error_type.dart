import '../constants/error_constants.dart';

enum ErrorType {
  database,
  unknown,
}

extension ErrorTypeHelper on ErrorType {
  String get message {
    switch (this) {
      case ErrorType.database:
        return ErrorConstants.databaseErrorMsg;
      case ErrorType.unknown:
        return ErrorConstants.unknownErrorMsg;
    }
  }
}
