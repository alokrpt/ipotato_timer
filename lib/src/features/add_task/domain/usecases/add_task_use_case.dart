import 'package:either_dart/either.dart';

import '../../../../core/error/custom_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/models/task_model.dart';
import '../repositories/add_task_repository.dart';

class AddTaskUseCase implements UseCase<void, AddTaskParams> {
  final AddTaskRepository repository;

  AddTaskUseCase(this.repository);

  @override
  Future<Either<CustomError, void>> call(AddTaskParams params) async {
    return await repository.addTask(params);
  }
}

class AddTaskParams {
  final TaskModel taskModel;

  const AddTaskParams({
    required this.taskModel,
  });
}
