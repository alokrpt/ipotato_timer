import 'package:drift/drift.dart';

import 'connection/connection.dart' as impl;
import 'database_model.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Tasks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  AppDatabase.forTesting(DatabaseConnection super.connection);
  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() => select(tasks).get();

  Stream<List<Task>> watchAllTasks() => select(tasks).watch();

  Future insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future updateTask(Task task) => update(tasks).replace(task);

  Future deleteTask(Task task) => delete(tasks).delete(task);
}
