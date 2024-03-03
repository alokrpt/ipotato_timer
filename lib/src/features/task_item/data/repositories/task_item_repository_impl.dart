import 'package:either_dart/either.dart';
import '../../domain/usecases/delete_task_use_case.dart';

import '../../../../core/error/custom_error.dart';
import '../../../../core/error/error_type.dart';
import '../../domain/repositories/task_item_repository.dart';
import '../../domain/usecases/update_task_use_case.dart';
import '../datasources/task_item_data_source.dart';

class TaskItemRepositoryImpl implements TaskItemRepository {
  final TaskItemDataSource dataSource;

  TaskItemRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<CustomError, void>> updateTask(UpdateTaskParams params) async =>
      _result(
        () => dataSource.updateTask(params),
      );

  @override
  Future<Either<CustomError, void>> deleteTask(DeleteTaskParams params) async =>
      _result(
        () => dataSource.deleteTask(params),
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
