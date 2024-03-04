import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/data/data_source/data_source_client_impl.dart';
import 'package:ipotato_timer/src/core/data/database/app_database.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../features/add_task/data/models/test_data_extension.dart';
import 'data_source_client_impl_test.mocks.dart';

@GenerateMocks([AppDatabase])
void main() {
  late MockAppDatabase databaseMock;
  late DataSourceClientImpl dataSource;

  setUp(() {
    databaseMock = MockAppDatabase();
    dataSource = DataSourceClientImpl(databaseMock);
  });
  group(
    'data_source_client_impl_test',
    () {
      final task = TaskModelTestData.demoTasks[0];
      test(
        'can list tasks',
        () async {
          // arrange
          final taskData = Task(
            duration: task.duration.inMilliseconds,
            id: task.id!,
            isCompleted: task.isCompleted,
            title: task.title,
            description: task.description,
          );
          when(databaseMock.getAllTasks()).thenAnswer((_) async {
            return [taskData];
          });
          // act
          final res = await dataSource.getList();
          // assert

          verify(databaseMock.getAllTasks()).called(1);
          expect(res, [task]);
        },
      );
      test(
        'can update tasks',
        () async {
          // arrange
          when(databaseMock.updateTask(any)).thenAnswer((_) async {
            return;
          });
          // act
          await dataSource.update(task);
          // assert

          verify(databaseMock.updateTask(any)).called(1);
        },
      );
      test(
        'can delete tasks',
        () async {
          // arrange
          when(databaseMock.deleteTaskById(any)).thenAnswer((_) async {
            return;
          });
          // act
          await dataSource.delete(1);
          // assert
          verify(databaseMock.deleteTaskById(any)).called(1);
        },
      );
      test(
        'can add tasks',
        () async {
          // arrange
          when(databaseMock.insertTask(any)).thenAnswer((_) async {
            return;
          });
          // act
          await dataSource.add(task);
          // assert
          verify(databaseMock.insertTask(any)).called(1);
        },
      );
    },
  );
}
