import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/presentation/gap.dart';
import '../../../../core/presentation/text_styles.dart';
import '../store/add_task_store.dart';
import 'widgets/button_item.dart';
import 'widgets/duration_input/duration_input_widget.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({
    super.key,
    required this.store,
  });
  final AddTaskStore store;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  ReactionDisposer? reactionDisposer;

  @override
  void initState() {
    super.initState();
    setupReactions();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.store.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    'Add Task',
                    style: TextStyles.pageTitle,
                  ),
                  const Gap(20),
                  TextFormField(
                    controller: widget.store.titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'Super Developer',
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
                    controller: widget.store.descriptionController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'e.g. john@gmail.com',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const Gap(20),
                  DurationInputWidget(
                    store: sl(),
                    onDurationChanged: (duration) {
                      widget.store.duration = duration;
                    },
                  ),
                ],
              )),
          const Gap(20),
          Observer(
            builder: (_) {
              if (widget.store.status == AddTaskStatus.loading) {
                return const CircularProgressIndicator();
              }
              return ButtonItem(
                text: 'Add Task',
                onTap: () {
                  if (widget.store.formKey.currentState?.validate() == false) {
                    return;
                  }
                  if (widget.store.duration == Duration.zero) {
                    Fluttertoast.showToast(
                      msg: 'Please enter duration',
                      backgroundColor: Colors.red.withOpacity(.6),
                      toastLength: Toast.LENGTH_SHORT,
                    );
                    return;
                  } else {
                    widget.store.addTask();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void setupReactions() {
    reactionDisposer ??=
        reaction((_) => widget.store.status, (AddTaskStatus status) {
      if (status == AddTaskStatus.success) {
        widget.store.reset();
        Navigator.of(context).pop(true);
      }
    });
  }

  @override
  void dispose() {
    reactionDisposer?.call();
    reactionDisposer = null;
    super.dispose();
  }
}
