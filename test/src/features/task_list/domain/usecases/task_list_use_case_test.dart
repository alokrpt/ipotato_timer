import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/core/usecase/usecase.dart';
import 'package:ipotato_timer/src/features/add_task/data/models/task_model.dart';
import 'package:ipotato_timer/src/features/task_list/domain/repositories/task_list_repository.dart';
import 'package:ipotato_timer/src/features/task_list/domain/usecases/task_list_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../add_task/data/models/test_data_extension.dart';
import 'task_list_use_case_test.mocks.dart';

@GenerateMocks([TaskListRepository])
void main() {
  late MockTaskListRepository repository;
  late TaskListUseCase useCase;

  setUp(() {
    repository = MockTaskListRepository();
    useCase = TaskListUseCase(repository);
  });
  group('task_list', () {
    final tasks = TaskModelTestData.demoTasks;
    provideDummy<Either<CustomError, List<TaskModel>>>(Right(tasks));

    test('should return entity when call to method from usecase is successful',
        () async {
      //arrange
      when(repository.taskList()).thenAnswer((_) async => Right(tasks));

      //act
      final result = await useCase(NoParams());

      //assert
      expect(result, Right(tasks));
      verify(useCase.call(NoParams()));
      verifyNoMoreInteractions(repository);
    });

    test('should return failure when call to method from usecase is failed',
        () async {
      //arrange
      when(repository.taskList()).thenAnswer(
          (_) async => const Left(CustomError(type: ErrorType.database)));

      //act
      final result = await useCase(NoParams());

      //assert
      expect(result, const Left(CustomError(type: ErrorType.database)));
      verify(repository.taskList());
      verifyNoMoreInteractions(repository);
    });
  });
}
