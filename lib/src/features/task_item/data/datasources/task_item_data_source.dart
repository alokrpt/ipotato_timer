import 'package:flutter/material.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';

import '../../../../core/data/data_source/data_source_client.dart';
import '../../../../core/error/custom_error.dart';
import '../../domain/usecases/delete_task_use_case.dart';
import '../../domain/usecases/update_task_use_case.dart';

abstract class TaskItemDataSource {
  /// update & delete task to database
  ///
  /// Throws [CustomError] for all error codes.
  Future<void> updateTask(UpdateTaskParams params);

  Future<void> deleteTask(DeleteTaskParams params);
}

class TaskItemDataSourceImpl implements TaskItemDataSource {
  final DataSourceClient client;
  TaskItemDataSourceImpl(this.client);

  @override
  Future<void> updateTask(UpdateTaskParams params) async {
    debugPrint('updateTask : ${params.task.toJson()}');
    try {
      await client.update(params.task);
    } catch (e) {
      throw CustomError(
        type: ErrorType.database,
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> deleteTask(DeleteTaskParams params) async {
    debugPrint('deleteTask : ${params.id}');
    try {
      await client.delete(params.id);
    } catch (e) {
      throw CustomError(
        type: ErrorType.database,
        message: e.toString(),
      );
    }
  }
}
