import 'package:drift/drift.dart';
import 'task_model.dart';

import '../../../../core/data/database/app_database.dart';

extension TaskModelExtension on TaskModel {
  TasksCompanion toDatabaseCompanion() => TasksCompanion(
        id: id == null ? const Value.absent() : Value(id!),
        title: Value(title),
        description: Value(description),
        duration: Value(duration.inMilliseconds),
        isCompleted: Value(isCompleted),
      );
}
