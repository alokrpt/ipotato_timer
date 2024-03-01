import 'package:either_dart/either.dart';

import '../../../../core/error/custom_error.dart';
import '../../../../core/error/error_type.dart';
import '../../domain/repositories/add_task_repository.dart';
import '../../domain/usecases/add_task_use_case.dart';
import '../datasources/add_task_data_source.dart';

class AddTaskRepositoryImpl implements AddTaskRepository {
  final AddTaskDataSource dataSource;

  AddTaskRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<CustomError, void>> addTask(
    AddTaskParams params,
  ) async =>
      _result(
        () => dataSource.addTask(params),
      );

  Future<Either<CustomError, T>> _result<T>(
      Future<T> Function() callback) async {
    try {
      return Right(await callback());
    } catch (e) {
      if (e is CustomError) {
        return Left(e);
      }
      return Left(
        CustomError(
          message: e.toString(),
          type: ErrorType.unknown,
        ),
      );
    }
  }
}
