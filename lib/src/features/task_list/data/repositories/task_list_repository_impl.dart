import 'package:either_dart/either.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';

import '../../../../core/error/error_type.dart';
import '../../../add_task/data/models/task_model.dart';
import '../../domain/repositories/task_list_repository.dart';
import '../datasources/task_list_remote_data_source.dart';

class TaskListRepositoryImpl implements TaskListRepository {
  final TaskListRemoteDataSource dataSource;

  TaskListRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<Either<CustomError, List<TaskModel>>> taskList() async => _result(
        () => dataSource.taskList(),
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
