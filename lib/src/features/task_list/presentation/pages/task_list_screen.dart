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
          // return ListView.custom(
          //   physics: const AlwaysScrollableScrollPhysics(),
          //   childrenDelegate: SliverChildBuilderDelegate(
          //     (context, index) {
          //     final task = taskListStore.tasks[index];
          //     return TaskItem(
          //         key: ValueKey(task.id),
          //         task: task,
          //     );
          //   },
          //     childCount: taskListStore.tasks.length,
          //     findChildIndexCallback: (key) {
          //       final ValueKey<int?> valueKey = key as ValueKey<int?>;
          //       final index = taskListStore.tasks
          //           .indexWhere((task) => task.id == valueKey.value);
          //       return index;
          //     },
          //   ),
          // );
          return ListView.builder(
            itemCount: taskListStore.tasks.length,
            itemBuilder: (context, index) {
              final task = taskListStore.tasks[index];
              return TaskItem(
                key: UniqueKey(),
                task: task,
                onDelete: taskListStore.deleteTask,
                taskStore: taskListStore.taskItemStores[task.id!] ??
                    TaskItemStore(
                      deleteTaskUseCase: sl(),
                      updateTaskUseCase: sl(),
                    ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: AddTaskDialog(
                  store: sl(),
                ),
              );
            },
          );
          if (result == true) {
            taskListStore.fetchTasks();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
