import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/presentation/gap.dart';
import '../../../../core/presentation/text_styles.dart';
import '../../../add_task/presentation/pages/widgets/button_item.dart';
import '../store/task_item_store.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    super.key,
    required this.taskStore,
    required this.onDelete,
    required task,
  }) {
    taskStore.init(task);
  }
  final TaskItemStore taskStore;
  final Function(int) onDelete;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final primaryColor = Theme.of(context).primaryColor;
      return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(20.0).copyWith(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleRow(primaryColor, context),
              const Gap(10),
              Text(
                taskStore.taskModel.title,
                style: TextStyles.titleText.copyWith(
                  color: Colors.green.shade800,
                ),
              ),
              const Gap(10),
              Text(
                taskStore.taskModel.description,
                style: TextStyles.actionText.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              if (taskStore.isFinished)
                ButtonItem(
                  onTap: () async {
                    await taskStore.completeTask();
                    onDelete(taskStore.taskModel.id!);
                  },
                  text: 'MARK COMPLETE',
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _titleRow(Color primaryColor, BuildContext context) {
    return taskStore.isFinished
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.multitrack_audio_rounded,
                color: primaryColor,
              ),
              const Gap(20),
              Text(
                'Finished',
                style: TextStyles.pageTitle.copyWith(
                  color: primaryColor,
                ),
              ),
              const Gap(20),
              Icon(
                Icons.multitrack_audio_rounded,
                color: primaryColor,
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                taskStore.formattedTime,
                style: TextStyles.pageTitle.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Gap(10),
              taskStore.isRunning
                  ? IconButton(
                      icon: const Icon(
                        Icons.pause,
                        size: 32,
                      ),
                      onPressed: () {
                        taskStore.pauseTask();
                      },
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.play_arrow,
                        size: 32,
                      ),
                      onPressed: () {
                        taskStore.startTask();
                      },
                    ),
              IconButton(
                onPressed: () async {
                  await taskStore.completeTask();
                  onDelete(taskStore.taskModel.id!);
                },
                icon: const Icon(
                  Icons.delete,
                  size: 32,
                ),
              )
            ],
          );
  }
}
