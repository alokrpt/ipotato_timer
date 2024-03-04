import '../../../../core/data/data_source/data_source_client.dart';
import '../../../../core/error/custom_error.dart';
import '../../../../core/error/error_type.dart';
import '../../../add_task/data/models/task_model.dart';

abstract class TaskListDataSource {
  /// get Task list from database
  ///
  /// Throws [CustomError] for all error codes.
  Future<List<TaskModel>> taskList();
}

class TaskListDataSourceImpl implements TaskListDataSource {
  final DataSourceClient client;
  TaskListDataSourceImpl(this.client);

  @override
  Future<List<TaskModel>> taskList() async {
    try {
      return await client.getList();
    } catch (e) {
      throw CustomError(type: ErrorType.database, message: e.toString());
    }
  }
}
