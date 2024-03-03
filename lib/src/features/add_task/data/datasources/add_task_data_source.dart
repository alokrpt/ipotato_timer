import 'package:flutter/material.dart';

import '../../../../core/database/data_source_client.dart';
import '../../domain/usecases/add_task_use_case.dart';

abstract class AddTaskDataSource {
  /// get  from server
  ///
  /// Throws [ServerException] for all error codes.
  Future<void> addTask(AddTaskParams params);
}

class AddTaskDataSourceImpl implements AddTaskDataSource {
  final DataSourceClient client;
  AddTaskDataSourceImpl(this.client);

  @override
  Future<void> addTask(AddTaskParams params) async {
    debugPrint('AddTaskDataSourceImpl ${params.taskModel.toJson()}');
  }
}
