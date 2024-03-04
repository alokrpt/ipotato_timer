import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/features/task_list/domain/usecases/task_list_use_case.dart';
import 'package:ipotato_timer/src/features/task_list/presentation/store/task_list_store.dart';
import 'package:mockito/annotations.dart';

import '../../../add_task/data/models/test_data_extension.dart';
import 'task_list_cubit_test.mocks.dart';

@GenerateMocks([TaskListUseCase])
void main() {
  late MockTaskListUseCase taskListUseCase;
  late TaskListStore store;

  setUp(() {
    taskListUseCase = MockTaskListUseCase();
    store = TaskListStore(
      taskListUseCase,
    );
  });

  group('task_list', () {
    var tasks = TaskModelTestData.demoTasks;

    test(
      'should return initial state',
      () => expect(store.status, TaskListStatus.initial),
    );
  });
}
