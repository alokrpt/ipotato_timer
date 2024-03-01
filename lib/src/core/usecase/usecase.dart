import 'package:either_dart/either.dart';

import '../error/custom_error.dart';

abstract class UseCase<Type, Params> {
  Future<Either<CustomError, Type>> call(Params params);
}

class NoParams {}
