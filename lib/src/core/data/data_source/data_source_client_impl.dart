import 'dart:async';

import 'package:ipotato_timer/src/core/data/database/app_database.dart';
import 'package:ipotato_timer/src/features/add_task/data/models/task_model.dart';
import 'package:ipotato_timer/src/features/add_task/data/models/task_model_extension.dart';

import 'data_source_client.dart';

class DataSourceClientImpl implements DataSourceClient {
  final AppDatabase appDatabase;

  DataSourceClientImpl(this.appDatabase);

  @override
  Future<void> add(TaskModel task) async {
    return await appDatabase.insertTask(task.toDatabaseCompanion());
  }

  @override
  Future<void> delete(int id) async {
    return await appDatabase.deleteTaskById(id);
  }

  @override
  Future<List<TaskModel>> getList() async {
    final list = await appDatabase.getAllTasks();
    return list.map((task) => TaskModel.fromDatabaseModel(task)).toList();
  }

  @override
  Future<void> update(TaskModel task) {
    return appDatabase.updateTask(task.toDatabaseCompanion());
  }
}
