import 'package:either_dart/either.dart';
import '../../../../core/error/custom_error.dart';
import '../usecases/delete_task_use_case.dart';

import '../usecases/update_task_use_case.dart';

abstract class TaskItemRepository {
  Future<Either<CustomError, void>> updateTask(UpdateTaskParams params);
  Future<Either<CustomError, void>> deleteTask(DeleteTaskParams params);
}
