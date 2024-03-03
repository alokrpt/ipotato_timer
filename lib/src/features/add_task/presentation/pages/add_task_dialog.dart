import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/presentation/gap.dart';
import '../../../../core/presentation/text_styles.dart';
import '../store/add_task_store.dart';
import 'widgets/duration_input/duration_input_widget.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({
    super.key,
    required this.store,
  });
  final AddTaskStore store;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: store.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Add Task',
            style: TextStyles.pageTitle,
          ),
          const Gap(20),
          TextFormField(
            controller: store.titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
          ),
          const Gap(20),
          TextFormField(
            controller: store.descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
          ),
          const Gap(20),
          DurationInputWidget(
            store: sl(),
            onDurationChanged: (duration) {
              store.duration = duration;
            },
          ),
          const Gap(20),
          Observer(
            builder: (context) {
              if (store.status == AddTaskStatus.loading) {
                return const CircularProgressIndicator();
              }
              return ElevatedButton(
                onPressed: () {
                  if (store.formKey.currentState?.validate() == false) {
                    return;
                  }
                  if (store.duration == Duration.zero) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please enter a duration'),
                      ),
                    );
                    return;
                  } else {
                    store.addTask();
                  }
                },
                child: const Text('Add Task'),
              );
            },
          ),
        ],
      ),
    );
  }
}
