import 'package:either_dart/either.dart';

import '../../../../core/error/custom_error.dart';
import '../../../add_task/data/models/task_model.dart';

abstract class TaskListRepository {
  Future<Either<CustomError, List<TaskModel>>> taskList();
}
