// Mocks generated by Mockito 5.4.4 from annotations
// in ipotato_timer/test/src/features/task_list/presentation/cubit/task_list_store_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:either_dart/either.dart' as _i5;
import 'package:ipotato_timer/src/core/error/custom_error.dart' as _i6;
import 'package:ipotato_timer/src/core/usecase/usecase.dart' as _i8;
import 'package:ipotato_timer/src/features/add_task/data/models/task_model.dart'
    as _i7;
import 'package:ipotato_timer/src/features/task_list/domain/repositories/task_list_repository.dart'
    as _i2;
import 'package:ipotato_timer/src/features/task_list/domain/usecases/task_list_use_case.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeTaskListRepository_0 extends _i1.SmartFake
    implements _i2.TaskListRepository {
  _FakeTaskListRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [TaskListUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockTaskListUseCase extends _i1.Mock implements _i3.TaskListUseCase {
  MockTaskListUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.TaskListRepository get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeTaskListRepository_0(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.TaskListRepository);

  @override
  _i4.Future<_i5.Either<_i6.CustomError, List<_i7.TaskModel>>> call(
          _i8.NoParams? params) =>
      (super.noSuchMethod(
        Invocation.method(
          #call,
          [params],
        ),
        returnValue: _i4
            .Future<_i5.Either<_i6.CustomError, List<_i7.TaskModel>>>.value(
            _i9.dummyValue<_i5.Either<_i6.CustomError, List<_i7.TaskModel>>>(
          this,
          Invocation.method(
            #call,
            [params],
          ),
        )),
      ) as _i4.Future<_i5.Either<_i6.CustomError, List<_i7.TaskModel>>>);
}
