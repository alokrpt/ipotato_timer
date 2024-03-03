import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ipotato_timer/src/features/task_item/presentation/store/task_item_store.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../add_task/presentation/pages/add_task_dialog.dart';
import '../../../task_item/presentation/widgets/task_item.dart';
import '../store/task_list_store.dart';

class TaskListScreen extends StatelessWidget {
  TaskListScreen({
    super.key,
    required this.taskListStore,
  }) {
    taskListStore.fetchTasks();
  }

  final TaskListStore taskListStore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iPotato Timer'),
      ),
      body: Observer(
        builder: (_) {
          if (taskListStore.status == TaskListStatus.loading ||
              taskListStore.status == TaskListStatus.initial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (taskListStore.status == TaskListStatus.failure) {
            return const Center(
              child: Text('Error loading tasks.'),
            );
          }

          if (taskListStore.tasks.isEmpty) {
            return const Center(
              child: Text('No tasks found.'),
            );
          }

          return ListView.builder(
            itemCount: taskListStore.tasks.length,
            itemBuilder: (context, index) {
              final task = taskListStore.tasks[index];
              return TaskItem(
                task: task,
                taskStore: TaskItemStore(
                  deleteTaskUseCase: sl(),
                  updateTaskUseCase: sl(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: AddTaskDialog(
                  store: sl(),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}