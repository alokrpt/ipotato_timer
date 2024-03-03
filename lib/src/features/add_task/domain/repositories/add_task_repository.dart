import 'package:either_dart/either.dart';
import '../../../../core/error/custom_error.dart';

import '../usecases/add_task_use_case.dart';

abstract class AddTaskRepository {
  Future<Either<CustomError, void>> addTask(
    AddTaskParams params,
  );
}
