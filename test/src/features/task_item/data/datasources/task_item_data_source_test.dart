import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/data/data_source/data_source_client.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/task_item/data/datasources/task_item_data_source.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/delete_task_use_case.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/update_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../add_task/data/models/test_data_extension.dart';
import 'task_item_data_source_test.mocks.dart';

@GenerateMocks([DataSourceClient])
void main() {
  late MockDataSourceClient client;
  late TaskItemDataSource dataSource;

  setUp(() {
    client = MockDataSourceClient();
    dataSource = TaskItemDataSourceImpl(client);
  });
  final taskList = TaskModelTestData.demoTasks;
  group('update_task', () {
    final params = UpdateTaskParams(task: taskList[0]);
    test('Should finish function call when database call is successfull',
        () async {
      //arrange
      when(client.update(params.task)).thenAnswer((_) async {
        return;
      });

      //act
      await dataSource.updateTask(params);

      //assert
      verify(client.update(any)).called(1);
    });

    test('Should throw CustomError on failure', () async {
      //arrange

      when(client.update(params.task)).thenAnswer((_) async {
        throw const CustomError(type: ErrorType.database);
      });

      //act
      final call = dataSource.updateTask(params);

      //assert
      expect(
        () => call,
        throwsA(const TypeMatcher<CustomError>()),
      );
    });
  });
  group('delete_task', () {
    const params = DeleteTaskParams(id: 45);
    test('Should finish function call when database call is successfull',
        () async {
      //arrange
      when(client.delete(params.id)).thenAnswer((_) async {
        return;
      });

      //act
      await dataSource.deleteTask(params);

      //assert
      verify(client.delete(any)).called(1);
    });

    test('Should throw CustomError on failure', () async {
      //arrange

      when(client.delete(params.id)).thenAnswer((_) async {
        throw const CustomError(type: ErrorType.database);
      });

      //act
      final call = dataSource.deleteTask(params);

      //assert
      expect(
        () => call,
        throwsA(const TypeMatcher<CustomError>()),
      );
    });
  });
}
