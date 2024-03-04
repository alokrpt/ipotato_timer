import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/task_list/data/datasources/task_list_data_source.dart';
import 'package:ipotato_timer/src/features/task_list/data/repositories/task_list_repository_impl.dart';
import 'package:ipotato_timer/src/features/task_list/domain/repositories/task_list_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../add_task/data/models/test_data_extension.dart';
import 'task_list_repository_impl_test.mocks.dart';

@GenerateMocks([
  TaskListDataSource,
])
void main() {
  late MockTaskListDataSource remoteDataSource;
  late TaskListRepository repository;

  setUp(() {
    remoteDataSource = MockTaskListDataSource();
    repository = TaskListRepositoryImpl(
      dataSource: remoteDataSource,
    );
  });
  var tasks = TaskModelTestData.demoTasks;

  group('task_list', () {
    test('should return correct result when requested from data base',
        () async {
      //arrange
      when(remoteDataSource.taskList()).thenAnswer((_) async => tasks);
      //act
      final result = await repository.taskList();
      //assert
      expect(result, Right(tasks));
    });
    test('should return failure when there is DB Failure', () async {
      //arrange
      when(remoteDataSource.taskList())
          .thenThrow(const CustomError(type: ErrorType.database));

      //act
      final result = await repository.taskList();
      //assert
      expect(result, const Left(CustomError(type: ErrorType.database)));
    });
  });
}
