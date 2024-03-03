
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/database/app_database.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class TaskModel with _$TaskModel {
  const TaskModel._();
  const factory TaskModel({
    required int? id,
    required String title,
    required String description,
    required Duration duration, // int milliseconds
    required bool isCompleted,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromDatabaseModel(Task task) => TaskModel(
        id: task.id,
        title: task.title,
        description: task.description ?? '',
        duration: Duration(milliseconds: task.duration),
        isCompleted: task.isCompleted,
      );
}
