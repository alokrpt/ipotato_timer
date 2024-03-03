import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../data/models/task_model.dart';
import '../../domain/usecases/add_task_use_case.dart';

part 'add_task_store.g.dart';

enum AddTaskStatus { initial, loading, success, failure }

class AddTaskStore extends _AddTaskStore with _$AddTaskStore {
  AddTaskStore(super.addTaskUseCase);
}

abstract class _AddTaskStore with Store {
  final AddTaskUseCase _addTaskUseCase;

  _AddTaskStore(this._addTaskUseCase);

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @observable
  Duration duration = const Duration(seconds: 0);

  @observable
  AddTaskStatus status = AddTaskStatus.initial;

  @action
  void setDuration(Duration value) => duration = value;

  @action
  Future<void> addTask() async {
    status = AddTaskStatus.loading;
    final result = await _addTaskUseCase(
      AddTaskParams(
        taskModel: TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          duration: duration,
          isCompleted: false,
          isRunning: false,
          id: null,
        ),
      ),
    );
    result.fold(
      (error) => status = AddTaskStatus.failure,
      (success) => status = AddTaskStatus.success,
    );
  }
}
