// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskItemStore on _TaskItemStore, Store {
  late final _$taskModelAtom =
      Atom(name: '_TaskItemStore.taskModel', context: context);

  @override
  TaskModel get taskModel {
    _$taskModelAtom.reportRead();
    return super.taskModel;
  }

  bool _taskModelIsInitialized = false;

  @override
  set taskModel(TaskModel value) {
    _$taskModelAtom.reportWrite(
        value, _taskModelIsInitialized ? super.taskModel : null, () {
      super.taskModel = value;
      _taskModelIsInitialized = true;
    });
  }

  late final _$remainingDurationAtom =
      Atom(name: '_TaskItemStore.remainingDuration', context: context);

  @override
  Duration get remainingDuration {
    _$remainingDurationAtom.reportRead();
    return super.remainingDuration;
  }

  @override
  set remainingDuration(Duration value) {
    _$remainingDurationAtom.reportWrite(value, super.remainingDuration, () {
      super.remainingDuration = value;
    });
  }

  late final _$_TaskItemStoreActionController =
      ActionController(name: '_TaskItemStore', context: context);

  @override
  void init(TaskModel taskModel) {
    final _$actionInfo = _$_TaskItemStoreActionController.startAction(
        name: '_TaskItemStore.init');
    try {
      return super.init(taskModel);
    } finally {
      _$_TaskItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTask() {
    final _$actionInfo = _$_TaskItemStoreActionController.startAction(
        name: '_TaskItemStore.startTask');
    try {
      return super.startTask();
    } finally {
      _$_TaskItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void pauseTask() {
    final _$actionInfo = _$_TaskItemStoreActionController.startAction(
        name: '_TaskItemStore.pauseTask');
    try {
      return super.pauseTask();
    } finally {
      _$_TaskItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void completeTask() {
    final _$actionInfo = _$_TaskItemStoreActionController.startAction(
        name: '_TaskItemStore.completeTask');
    try {
      return super.completeTask();
    } finally {
      _$_TaskItemStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
taskModel: ${taskModel},
remainingDuration: ${remainingDuration}
    ''';
  }
}
