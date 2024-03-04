import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/task_item/data/datasources/task_item_data_source.dart';
import 'package:ipotato_timer/src/features/task_item/data/repositories/task_item_repository_impl.dart';
import 'package:ipotato_timer/src/features/task_item/domain/repositories/task_item_repository.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/delete_task_use_case.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/update_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../add_task/data/models/test_data_extension.dart';
import '../../../add_task/domain/usecases/add_task_use_case_test.dart';
import 'task_item_repository_impl_test.mocks.dart';

@GenerateMocks([
  TaskItemDataSource,
])
void main() {
  late MockTaskItemDataSource dataSource;
  late TaskItemRepository repository;

  setUp(() {
    dataSource = MockTaskItemDataSource();

    repository = TaskItemRepositoryImpl(
      dataSource: dataSource,
    );
  });

  group('update_item', () {
    final params = UpdateTaskParams(task: TaskModelTestData.demoTasks[0]);
    test('should return correct result when requested from data base',
        () async {
      //arrange
      when(dataSource.updateTask(any)).thenAnswer((_) async {});
      //act
      final result = await repository.updateTask(params);
      //assert
      expect(result, Right(returnVoid()));
    });
    test('should return failure when there is DB Failure', () async {
      //arrange
      when(dataSource.updateTask(params))
          .thenThrow(const CustomError(type: ErrorType.database));

      //act
      final result = await repository.updateTask(params);
      //assert
      expect(result, const Left(CustomError(type: ErrorType.database)));
    });
  });

  group('delete_item', () {
    const params = DeleteTaskParams(id: 45);
    test('should return correct result when requested from data base',
        () async {
      //arrange
      when(dataSource.deleteTask(any)).thenAnswer((_) async {});
      //act
      final result = await repository.deleteTask(params);
      //assert
      expect(result, Right(returnVoid()));
    });
    test('should return failure when there is DB Failure', () async {
      //arrange
      when(dataSource.deleteTask(params))
          .thenThrow(const CustomError(type: ErrorType.database));

      //act
      final result = await repository.deleteTask(params);
      //assert
      expect(result, const Left(CustomError(type: ErrorType.database)));
    });
  });
}
