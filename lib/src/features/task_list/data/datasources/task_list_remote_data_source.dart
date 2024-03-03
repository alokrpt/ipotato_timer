import 'package:ipotato_timer/src/core/error/custom_error.dart';

import '../../../../core/data/data_source/data_source_client.dart';
import '../../../../core/error/error_type.dart';
import '../../../add_task/data/models/task_model.dart';

abstract class TaskListRemoteDataSource {
  /// get Task list from database
  ///
  /// Throws [CustomError] for all error codes.
  Future<List<TaskModel>> taskList();
}

class TaskListRemoteDataSourceImpl implements TaskListRemoteDataSource {
  final DataSourceClient client;
  TaskListRemoteDataSourceImpl(this.client);

  @override
  Future<List<TaskModel>> taskList() async {
    try {
      return await client.getList();
    } catch (e) {
      throw CustomError(type: ErrorType.database, message: e.toString());
    }
  }

  List<TaskModel> get demoTasks => [
        const TaskModel(
          id: 45,
          title: 'Make Food',
          description: 'Make Food Desc',
          duration: Duration(seconds: 30),
          isCompleted: false,
        ),
        const TaskModel(
          id: 53,
          title: 'Make Food 1',
          description: 'Make Food Desc 1',
          duration: Duration(seconds: 46),
          isCompleted: false,
        ),
        const TaskModel(
          id: 22,
          title: 'Make Food 2',
          description: 'Make Food Desc 2',
          duration: Duration(seconds: 350),
          isCompleted: false,
        ),
        const TaskModel(
          id: 222,
          title: 'Make Food 22',
          description: 'Make Food Desc 3',
          duration: Duration(seconds: 5),
          isCompleted: false,
        ),
      ];
}
