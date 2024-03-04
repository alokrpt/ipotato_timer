import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/data/data_source/data_source_client.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/add_task/data/datasources/add_task_data_source.dart';
import 'package:ipotato_timer/src/features/add_task/domain/usecases/add_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../models/test_data_extension.dart';
import 'add_task_data_source_test.mocks.dart';

@GenerateMocks([DataSourceClient])
void main() {
  late MockDataSourceClient client;
  late AddTaskDataSource remoteDataSource;

  setUp(() {
    client = MockDataSourceClient();
    remoteDataSource = AddTaskDataSourceImpl(client);
  });

  group('add_task', () {
    final params = AddTaskParams(
      taskModel: TaskModelTestData.demoTasks[0],
    );
    test('Should finish function call when database call is successfull',
        () async {
      //arrange
      when(client.add(any)).thenAnswer((_) async {});

      //act
      await remoteDataSource.addTask(params);

      //assert
      verify(client.add(any)).called(1);
    });

    test('Should throw CustomError on failure', () async {
      //arrange

      when(client.add(any)).thenAnswer((_) async {
        throw const CustomError(type: ErrorType.database);
      });

      //act
      final call = remoteDataSource.addTask(params);

      //assert
      expect(
        () => call,
        throwsA(const TypeMatcher<CustomError>()),
      );
    });
  });
}
