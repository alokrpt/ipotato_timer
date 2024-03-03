import 'package:either_dart/either.dart';
import '../../../../core/error/custom_error.dart';
import '../../../../core/usecase/usecase.dart';

import '../../../add_task/data/models/task_model.dart';
import '../repositories/task_list_repository.dart';

class TaskListUseCase implements UseCase<List<TaskModel>, NoParams> {
  final TaskListRepository repository;

  TaskListUseCase(this.repository);

  @override
  Future<Either<CustomError, List<TaskModel>>> call(NoParams params) async {
    return await repository.taskList();
  }
}
