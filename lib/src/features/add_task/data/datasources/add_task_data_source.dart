import '../../../../core/data/data_source/data_source_client.dart';
import '../../../../core/error/custom_error.dart';
import '../../../../core/error/error_type.dart';
import '../../domain/usecases/add_task_use_case.dart';

abstract class AddTaskDataSource {
  /// add task to database
  ///
  /// Throws [CustomError] for all error codes.
  Future<void> addTask(AddTaskParams params);
}

class AddTaskDataSourceImpl implements AddTaskDataSource {
  final DataSourceClient client;
  AddTaskDataSourceImpl(this.client);

  @override
  Future<void> addTask(AddTaskParams params) async {
    try {
      await client.add(params.taskModel);
    } catch (e) {
      throw CustomError(
        type: ErrorType.database,
        message: e.toString(),
      );
    }
  }
}
