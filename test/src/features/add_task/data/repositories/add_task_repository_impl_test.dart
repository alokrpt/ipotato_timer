import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/add_task/data/datasources/add_task_data_source.dart';
import 'package:ipotato_timer/src/features/add_task/data/repositories/add_task_repository_impl.dart';
import 'package:ipotato_timer/src/features/add_task/domain/repositories/add_task_repository.dart';
import 'package:ipotato_timer/src/features/add_task/domain/usecases/add_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../models/test_data_extension.dart';
import 'add_task_repository_impl_test.mocks.dart';

@GenerateMocks([
  AddTaskDataSource,
])
void main() {
  late MockAddTaskDataSource dataSource;
  late AddTaskRepository repository;

  setUp(() {
    dataSource = MockAddTaskDataSource();
    repository = AddTaskRepositoryImpl(
      dataSource: dataSource,
    );
  });
  final params = AddTaskParams(taskModel: TaskModelTestData.demoTasks[0]);

  group('add_task', () {
    test('should return correct result when requested from data source',
        () async {
      //arrange
      when(dataSource.addTask(any)).thenAnswer((_) async {
        return;
      });
      //act
      final result = await repository.addTask(params);
      //assert
      expect(result, const Right(null));
    });
    test('should return unknown failure when there is unknowm failure',
        () async {
      //arrange
      when(dataSource.addTask(any)).thenThrow(Exception());

      //act
      final result = await repository.addTask(params);
      //assert

      expect(result, const TypeMatcher<Left>());
      expect(result.left.type, ErrorType.unknown);
    });
    test('should return custom error when there is DB Failure', () async {
      //arrange
      when(dataSource.addTask(any))
          .thenThrow(const CustomError(type: ErrorType.database));

      //act
      final result = await repository.addTask(params);

      //assert
      expect(result, const TypeMatcher<Left>());
      expect(result.left, const TypeMatcher<CustomError>());
      expect(result.left, const CustomError(type: ErrorType.database));
    });
  });
}
