import '../../../../core/usecase/usecase.dart';
import '../../../add_task/data/models/task_model.dart';
import '../../domain/usecases/task_list_use_case.dart';
import 'package:mobx/mobx.dart';

part 'task_list_store.g.dart';

enum TaskListStatus { initial, loading, loaded, failure }

class TaskListStore extends _TaskListStore with _$TaskListStore {
  TaskListStore(super._taskListUseCase);
}

abstract class _TaskListStore with Store {
  final TaskListUseCase _taskListUseCase;

  _TaskListStore(this._taskListUseCase);

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
        tasks.clear();
        tasks.addAll(fetchedTasks);
      },
    );
  }
}
