import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../store/task_item_store.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    super.key,
    required this.taskStore,
    required task,
  }) {
    taskStore.init(task);
  }
  final TaskItemStore taskStore;
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return ListTile(
        title: Text(
            '${taskStore.taskModel.title}   - -      ${taskStore.formattedTime}'),
        subtitle: Text(taskStore.taskModel.description),
        leading: IconButton(
          onPressed: () {
            taskStore.completeTask();
          },
          icon: const Icon(Icons.delete),
        ),
        trailing: taskStore.isRunning
            ? IconButton(
                icon: const Icon(Icons.pause),
                onPressed: () {
                  taskStore.pauseTask();
                },
              )
            : IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  taskStore.startTask();
                },
              ),
      );
    });
  }
}
