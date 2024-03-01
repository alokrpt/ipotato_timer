import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/failure_type.dart';
import '../../domain/entities/add_task_entity.dart';
import '../../domain/usecases/add_task_use_case.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit({required this.addTaskUseCase,}) : super(AddTaskInitial());
  final AddTaskUseCase addTaskUseCase;

    Future<void> addTask({required String id}) async {
    emit(AddTaskLoading());
    final result = await addTaskUseCase(AddTaskParams(id: id));
    result.fold(
        (failure) =>
            emit(AddTaskFailed(FailureTypeHelper.fromFailure(failure))),
        (entity) => emit(AddTaskLoaded(addTaskEntity: entity)));
  }
}
