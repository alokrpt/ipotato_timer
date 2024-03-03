import 'package:either_dart/either.dart';
import '../../../../core/error/custom_error.dart';
import '../../../add_task/data/models/task_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/task_item_repository.dart';

class UpdateTaskUseCase implements UseCase<void, UpdateTaskParams> {
  final TaskItemRepository repository;

  UpdateTaskUseCase(this.repository);

  @override
  Future<Either<CustomError, void>> call(UpdateTaskParams params) async {
    return await repository.updateTask(params);
  }
}

class UpdateTaskParams {
  final TaskModel task;

  const UpdateTaskParams({
    required this.task,
  });
}
