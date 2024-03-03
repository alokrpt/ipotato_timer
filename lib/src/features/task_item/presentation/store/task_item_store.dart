import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:mobx/mobx.dart';

import '../../../add_task/data/models/task_model.dart';
import '../../domain/usecases/delete_task_use_case.dart';
import '../../domain/usecases/update_task_use_case.dart';

part 'task_item_store.g.dart';

class TaskItemStore extends _TaskItemStore with _$TaskItemStore {
  TaskItemStore({
    required super.deleteTaskUseCase,
    required super.updateTaskUseCase,
  });
}

abstract class _TaskItemStore with Store {
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  _TaskItemStore({
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
  });

  @observable
  late TaskModel taskModel;

  @observable
  Duration remainingDuration = Duration.zero;

  @action
  void init(TaskModel taskModel) {
    this.taskModel = taskModel;
    remainingDuration = taskModel.duration;
  }

  Timer? _timer;

  @action
  void startTask() {
    if (isFinished) {
      pauseTask();
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingDuration -= const Duration(seconds: 1);
      if (isFinished) {
        pauseTask();
      }
    });
  }

  @action
  void pauseTask() {
    _timer?.cancel();
    final updatedTask = taskModel.copyWith(duration: remainingDuration);
    final result = updateTaskUseCase(UpdateTaskParams(task: updatedTask));
    result.fold(
      (error) => null,
      (success) => taskModel = updatedTask,
    );
  }

  @action
  void completeTask() {
    final updatedTask = taskModel.copyWith(isCompleted: true);
    final result = deleteTaskUseCase(DeleteTaskParams(task: updatedTask));
    result.fold(
      (error) => null,
      (success) => taskModel = updatedTask,
    );
  }

  @computed
  bool get isFinished => remainingDuration.inSeconds <= 0;

  @computed
  bool get isRunning => _timer != null && _timer!.isActive && !isFinished;

  @computed
  String get formattedTime {
    final hours = remainingDuration.inHours;
    final minutes = remainingDuration.inMinutes.remainder(60);
    final remainingSeconds = remainingDuration.inSeconds.remainder(60);

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
