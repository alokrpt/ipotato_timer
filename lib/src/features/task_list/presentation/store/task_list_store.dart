import 'package:mobx/mobx.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../add_task/data/models/task_model.dart';
import '../../../task_item/presentation/store/task_item_store.dart';
import '../../domain/usecases/task_list_use_case.dart';

part 'task_list_store.g.dart';

enum TaskListStatus { initial, loading, loaded, failure }

class TaskListStore extends _TaskListStore with _$TaskListStore {
  TaskListStore(super._taskListUseCase);
}

abstract class _TaskListStore with Store {
  final TaskListUseCase _taskListUseCase;

  _TaskListStore(this._taskListUseCase);

  Map<int, TaskItemStore> taskItemStores = {};

  @observable
  ObservableList<TaskModel> tasks = ObservableList<TaskModel>();

  @observable
  TaskListStatus status = TaskListStatus.initial;

  @action
  Future<void> fetchTasks() async {
    final result = await _taskListUseCase.call(NoParams());
    result.fold(
      (failure) => status = TaskListStatus.failure,
      (fetchedTasks) {
        status = TaskListStatus.loaded;
        _refreshListItems(fetchedTasks);
      },
    );
  }

  void _refreshListItems(List<TaskModel> fetchedTasks) {
    List<int> taskIds = [];

    for (var element in fetchedTasks) {
      if (!tasks.contains(element) && element.id != null) {
        tasks.add(element);
        taskItemStores[element.id!] = TaskItemStore(
          deleteTaskUseCase: sl(),
          updateTaskUseCase: sl(),
        );
      }
      taskIds.add(element.id!);
    }

    tasks.where((element) {
      bool toRemote = !taskIds.contains(element.id);
      if (toRemote) {
        taskItemStores.remove(element.id);
      }
      return toRemote;
    });
  }

  @action
  void deleteTask(int id) {
    tasks.removeWhere((element) => element.id == id);
    taskItemStores.remove(id);
  }
}
