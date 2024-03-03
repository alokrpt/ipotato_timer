import 'dart:async';

import '../../../../core/audio/audio_player.dart';
import 'package:mobx/mobx.dart';

import '../../../add_task/data/models/task_model.dart';
import '../../domain/usecases/delete_task_use_case.dart';
import '../../domain/usecases/update_task_use_case.dart';

part 'task_item_store.g.dart';

class TaskItemStore extends _TaskItemStore with _$TaskItemStore {
  TaskItemStore({
    required super.deleteTaskUseCase,
    required super.updateTaskUseCase,
    required super.audioPlayer,
  });
}

abstract class _TaskItemStore with Store {
  final DeleteTaskUseCase deleteTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;
  final AudioPlayer audioPlayer;

  _TaskItemStore({
    required this.deleteTaskUseCase,
    required this.updateTaskUseCase,
    required this.audioPlayer,
  });

  @observable
  late TaskModel taskModel;

  @observable
  Duration remainingDuration = const Duration(seconds: -1);

  @observable
  bool isRunning = false;

  @action
  void init(TaskModel taskModel) {
    this.taskModel = taskModel;
    if (remainingDuration == const Duration(seconds: -1)) {
      remainingDuration = taskModel.duration;
    }
  }

  Timer? _timer;

  @action
  void startTask() {
    if (isFinished) {
      pauseTask();
      return;
    }
    isRunning = true;
    _timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingDuration -= const Duration(seconds: 1);
      if (isFinished) {
        playAudio();
        pauseTask();
      }
    });
  }

  @action
  Future<void> pauseTask() async {
    _timer?.cancel();
    _timer = null;
    isRunning = false;
    final updatedTask = taskModel.copyWith(duration: remainingDuration);
    final result = await updateTaskUseCase(UpdateTaskParams(task: updatedTask));
    result.fold(
      (error) => null,
      (success) => taskModel = updatedTask,
    );
  }

  @action
  Future<void> completeTask() async {
    await pauseTask();
    stopAudio();
    final updatedTask = taskModel.copyWith(isCompleted: true);
    final result =
        await deleteTaskUseCase(DeleteTaskParams(id: updatedTask.id!));
    result.fold(
      (error) => null,
      (success) => taskModel = updatedTask,
    );
  }

  @computed
  bool get isFinished {
    return remainingDuration.inSeconds <= 0;
  }

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

  void playAudio() {
    isPlaying = true;
    audioPlayer.play();
  }

  bool isPlaying = false;
  void stopAudio() {
    if (isPlaying) {
      audioPlayer.stop();
      isPlaying = false;
    }
  }
}
