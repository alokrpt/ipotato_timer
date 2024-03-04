import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/presentation/gap.dart';
import '../../../add_task/presentation/pages/add_task_dialog.dart';
import '../../../task_item/presentation/store/task_item_store.dart';
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
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          Strings.appName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
              child: Text(Strings.errorLoadingTasks),
            );
          }

          if (taskListStore.tasks.isEmpty) {
            return _emptyStateWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
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
                        audioPlayer: sl(),
                      ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: _floatingButton(context),
    );
  }

  FloatingActionButton _floatingButton(BuildContext context) {
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onPressed: () async {
        final result = await showDialog(
          context: context,
          useSafeArea: true,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              insetPadding: const EdgeInsets.all(30),
              child: AddTaskDialog(
                store: sl(),
              ),
            );
          },
        );
        if (result == true) {
          taskListStore.fetchTasks();
        }
      },
      child: const Icon(
        Icons.add,
        size: 34,
      ),
    );
  }

  Align _emptyStateWidget() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 120,
          right: 20,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              Strings.noTimers,
            ),
            const Gap(10),
            Image.asset(
              'assets/images/down_arrow.png',
              height: 100,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
