import 'package:freezed_annotation/freezed_annotation.dart';

import 'error_type.dart';

part 'custom_error.freezed.dart';


@freezed
abstract class CustomError with _$CustomError {
  const CustomError._();
  const factory CustomError({
    required ErrorType type,
    String? message,
  }) = _CustomError;
}
