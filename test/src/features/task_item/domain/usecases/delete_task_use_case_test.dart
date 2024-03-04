import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/error/custom_error.dart';
import 'package:ipotato_timer/src/core/error/error_type.dart';
import 'package:ipotato_timer/src/features/task_item/domain/repositories/task_item_repository.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/delete_task_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_task_use_case_test.mocks.dart';

@GenerateMocks([TaskItemRepository])
void main() {
  late MockTaskItemRepository repository;
  late DeleteTaskUseCase useCase;

  setUp(() {
    repository = MockTaskItemRepository();
    useCase = DeleteTaskUseCase(repository);
  });
  group('delete_task', () {
    const params = DeleteTaskParams(
      id: 0,
    );

    provideDummy<Either<CustomError, void>>(Right(returnVoid()));

    test(
        'should complete without error when call to method from usecase is successful',
        () async {
      //arrange
      when(repository.deleteTask(any))
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
      when(repository.deleteTask(any)).thenAnswer(
          (_) async => const Left(CustomError(type: ErrorType.database)));

      //act
      final result = await useCase(params);

      //assert
      expect(result, const Left(CustomError(type: ErrorType.database)));
      verify(repository.deleteTask(params));
      verifyNoMoreInteractions(repository);
    });
  });
}

void returnVoid() {}
