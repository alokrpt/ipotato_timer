import '../../../features/add_task/data/models/task_model.dart';

abstract class DataSourceClient {
  Future<void> update(TaskModel task);

  Future<void> add(TaskModel task);

  Future<void> delete(int id);

  Future<List<TaskModel>> getList();
}
