part of 'add_task_cubit.dart';

abstract class AddTaskState extends Equatable {
  const AddTaskState();
  
  @override
  List<Object> get props => [];
}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskLoaded extends AddTaskState {
    final AddTaskEntity addTaskEntity;

    const AddTaskLoaded({required this.addTaskEntity});

      @override
  List<Object> get props => [addTaskEntity];
}

class AddTaskFailed extends AddTaskState {
    final FailureType type;

    const AddTaskFailed(this.type);

    @override
    List<Object> get props => [type];
}
