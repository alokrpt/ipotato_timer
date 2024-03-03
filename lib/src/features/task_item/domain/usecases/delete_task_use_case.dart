import 'package:either_dart/either.dart';

import '../../../../core/error/custom_error.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/task_item_repository.dart';

class DeleteTaskUseCase implements UseCase<void, DeleteTaskParams> {
  final TaskItemRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Either<CustomError, void>> call(DeleteTaskParams params) async {
    return await repository.deleteTask(params);
  }
}

class DeleteTaskParams {
  final int id;

  const DeleteTaskParams({
    required this.id,
  });
}
