import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/data/data_source/data_source_client.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/task_list/data/datasources/task_list_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../add_task/data/models/test_data_extension.dart';
import 'task_list_data_source_test.mocks.dart';

@GenerateMocks([DataSourceClient])
void main() {
  late MockDataSourceClient client;
  late TaskListDataSource remoteDataSource;

  setUp(() {
    client = MockDataSourceClient();
    remoteDataSource = TaskListDataSourceImpl(client);
  });
  final taskList = TaskModelTestData.demoTasks;
  group('add_task', () {
    test('Should finish function call when database call is successfull',
        () async {
      //arrange
      when(client.getList()).thenAnswer((_) async {
        return taskList;
      });

      //act
      final result = await remoteDataSource.taskList();

      //assert
      verify(client.getList()).called(1);
      expect(result, taskList);
    });

    test('Should throw CustomError on failure', () async {
      //arrange

      when(client.getList()).thenAnswer((_) async {
        throw const CustomError(type: ErrorType.database);
      });

      //act
      final call = remoteDataSource.taskList();

      //assert
      expect(
        () => call,
        throwsA(const TypeMatcher<CustomError>()),
      );
    });
  });
}
