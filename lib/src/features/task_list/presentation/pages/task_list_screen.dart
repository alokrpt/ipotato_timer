import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ipotato_timer/src/core/presentation/gap.dart';

import '../../../../core/dependency_injection/injection_container.dart';
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
          'iPotato Timer',
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
              child: Text('Error loading tasks.'),
            );
          }

          if (taskListStore.tasks.isEmpty) {
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
                      'No timers active. \nPress here to start a new one',
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
                      audioPlayer: sl(),
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
            useSafeArea: true,

            builder: (context) {
              return Dialog(
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
          Icons.add_circle_outline_sharp,
          size: 35,
        ),
      ),
    );
  }
}
