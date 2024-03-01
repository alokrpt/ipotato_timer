import '../constants/error_constants.dart';

enum ErrorType {
  database,
  noData,
  unknown,
}

extension ErrorTypeHelper on ErrorType {
  String get message {
    switch (this) {
      case ErrorType.noData:
        return ErrorConstants.noDataErrorMsg;
      case ErrorType.database:
        return ErrorConstants.databaseErrorMsg;
      case ErrorType.unknown:
        return ErrorConstants.unknownErrorMsg;
    }
  }
}
