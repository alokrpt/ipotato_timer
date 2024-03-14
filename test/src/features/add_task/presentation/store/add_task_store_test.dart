import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/features/add_task/domain/usecases/add_task_use_case.dart';
import 'package:ipotato_timer/src/features/add_task/presentation/store/add_task_store.dart';
import 'package:mockito/annotations.dart';

import 'add_task_store_test.mocks.dart';

@GenerateMocks([AddTaskUseCase])
void main() {
  late MockAddTaskUseCase addTaskUseCase;
  late AddTaskStore store;

  setUp(() {
    addTaskUseCase = MockAddTaskUseCase();
    store = AddTaskStore(
      addTaskUseCase,
    );
  });

  group('add_task', () {
    // final params = AddTaskParams(taskModel: TaskModelTestData.demoTasks[0]);

    test(
      'should return initial state',
      () => expect(store.status, AddTaskStatus.initial),
    );
  });
}
