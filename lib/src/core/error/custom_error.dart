import 'error_type.dart';

class CustomError {
  final ErrorType type;
  final String? message;

  const CustomError({
    required this.type,
    this.message,
  });

  @override
  String toString() => 'CustomError( type: $type, message: $message )';
}
