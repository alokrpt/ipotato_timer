import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/add_task/domain/repositories/add_task_repository.dart';
import 'package:ipotato_timer/src/features/add_task/domain/usecases/add_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../data/models/test_data_extension.dart';
import 'add_task_use_case_test.mocks.dart';

@GenerateMocks([AddTaskRepository])
void main() {
  late MockAddTaskRepository repository;
  late AddTaskUseCase useCase;

  setUp(() {
    repository = MockAddTaskRepository();
    useCase = AddTaskUseCase(repository);
  });
  group('add_task', () {
    final params = AddTaskParams(
      taskModel: TaskModelTestData.demoTasks[0],
    );

    provideDummy<Either<CustomError, void>>(Right(returnVoid()));

    test(
        'should complete without error when call to method from usecase is successful',
        () async {
      //arrange
      when(repository.addTask(any))
          .thenAnswer((_) async => Right(returnVoid()));

      //act
      final result = await useCase(params);

      //assert
      expect(result, const Right(null));
      verify(useCase.call(params));
      verifyNoMoreInteractions(repository);
    });

    test('should return failure when call to method from usecase is failed',
        () async {
      //arrange
      when(repository.addTask(any)).thenAnswer(
          (_) async => const Left(CustomError(type: ErrorType.database)));

      //act
      final result = await useCase(params);

      //assert
      expect(result, const Left(CustomError(type: ErrorType.database)));
      verify(repository.addTask(params));
      verifyNoMoreInteractions(repository);
    });
  });
}

void returnVoid() {}
