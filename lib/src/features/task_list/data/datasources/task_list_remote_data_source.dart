import 'package:flutter/cupertino.dart';

import '../../../../core/database/data_source_client.dart';
import '../../../add_task/data/models/task_model.dart';

abstract class TaskListRemoteDataSource {
  /// get  from server
  ///
  /// Throws [ServerException] for all error codes.
  Future<List<TaskModel>> taskList();
}

class TaskListRemoteDataSourceImpl implements TaskListRemoteDataSource {
  final DataSourceClient client;
  TaskListRemoteDataSourceImpl(this.client);

  @override
  Future<List<TaskModel>> taskList() async {
    debugPrint('Task List DS');
    await Future.delayed(const Duration(seconds: 2));
    return [
      const TaskModel(
        id: 45,
        title: 'Make Food',
        description: 'Make Food Desc',
        duration: Duration(seconds: 30),
        isCompleted: false,
        isRunning: false,
      ),
      const TaskModel(
        id: 53,
        title: 'Make Food 1',
        description: 'Make Food Desc 1',
        duration: Duration(seconds: 46),
        isCompleted: false,
        isRunning: false,
      ),
      const TaskModel(
        id: 22,
        title: 'Make Food 2',
        description: 'Make Food Desc 2',
        duration: Duration(seconds: 350),
        isCompleted: false,
        isRunning: false,
      ),
      const TaskModel(
        id: 222,
        title: 'Make Food 22',
        description: 'Make Food Desc 3',
        duration: Duration(seconds: 5),
        isCompleted: false,
        isRunning: false,
      ),
    ];
  }
}
