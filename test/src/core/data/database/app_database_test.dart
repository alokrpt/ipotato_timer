import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/data/database/app_database.dart';
import 'package:ipotato_timer/src/features/add_task/data/models/task_model_extension.dart';

import '../../../features/add_task/data/models/test_data_extension.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    final inMemory = DatabaseConnection(NativeDatabase.memory());
    database = AppDatabase.forTesting(inMemory);
  });

  tearDown(() => database.close());
  final task = TaskModelTestData.demoTasks[0];
  test('can insert and retrieve tasks', () async {
    await database.insertTask(task.toDatabaseCompanion());

    final result = await database.getAllTasks();
    expect(result.length, 1);
    expect(result.map((e) => e.title), contains(task.title));
  });
  test('can delete task entries', () async {
    await database.insertTask(task.toDatabaseCompanion());
    await database.deleteTaskById(task.id!);

    final result = await database.getAllTasks();
    expect(result.length, 0);
  });
  test('can update task entries', () async {
    await database.insertTask(task.toDatabaseCompanion());
    await database
        .updateTask(task.copyWith(title: 'New Title').toDatabaseCompanion());

    final result = await database.getAllTasks();
    expect(result.map((e) => e.title), contains('New Title'));
  });
}
