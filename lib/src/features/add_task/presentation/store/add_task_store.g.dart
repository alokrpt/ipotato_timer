// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_task_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddTaskStore on _AddTaskStore, Store {
  late final _$durationAtom =
      Atom(name: '_AddTaskStore.duration', context: context);

  @override
  Duration get duration {
    _$durationAtom.reportRead();
    return super.duration;
  }

  @override
  set duration(Duration value) {
    _$durationAtom.reportWrite(value, super.duration, () {
      super.duration = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_AddTaskStore.status', context: context);

  @override
  AddTaskStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AddTaskStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_AddTaskStore.addTask', context: context);

  @override
  Future<void> addTask() {
    return _$addTaskAsyncAction.run(() => super.addTask());
  }

  late final _$_AddTaskStoreActionController =
      ActionController(name: '_AddTaskStore', context: context);

  @override
  void setDuration(Duration value) {
    final _$actionInfo = _$_AddTaskStoreActionController.startAction(
        name: '_AddTaskStore.setDuration');
    try {
      return super.setDuration(value);
    } finally {
      _$_AddTaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$_AddTaskStoreActionController.startAction(
        name: '_AddTaskStore.reset');
    try {
      return super.reset();
    } finally {
      _$_AddTaskStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
duration: ${duration},
status: ${status}
    ''';
  }
}
