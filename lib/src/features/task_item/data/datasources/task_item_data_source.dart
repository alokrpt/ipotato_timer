import 'package:flutter/material.dart';

import '../../../../core/database/data_source_client.dart';
import '../../domain/usecases/delete_task_use_case.dart';
import '../../domain/usecases/update_task_use_case.dart';

abstract class TaskItemDataSource {
  /// get  from server
  ///
  /// Throws [ServerException] for all error codes.
  Future<void> updateTask(UpdateTaskParams params);

  Future<void> deleteTask(DeleteTaskParams params);
}

class TaskItemDataSourceImpl implements TaskItemDataSource {
  final DataSourceClient client;
  TaskItemDataSourceImpl(this.client);

  @override
  Future<void> updateTask(UpdateTaskParams params) async {
    debugPrint('updateTask : ${params.task.toJson()}');
  }

  @override
  Future<void> deleteTask(DeleteTaskParams params) async {
    debugPrint('deleteTask : ${params.task.toJson()}');
  }
}
