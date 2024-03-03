import 'package:flutter/material.dart';

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
    return ListTile(
      title: Text(taskStore.taskModel.title),
      subtitle: Text(taskStore.taskModel.description),
    );
  }
}
