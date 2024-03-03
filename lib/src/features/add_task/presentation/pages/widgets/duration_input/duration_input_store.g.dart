// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'duration_input_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DurationInputStore on _DurationInputStore, Store {
  Computed<Duration>? _$totalDurationComputed;

  @override
  Duration get totalDuration =>
      (_$totalDurationComputed ??= Computed<Duration>(() => super.totalDuration,
              name: '_DurationInputStore.totalDuration'))
          .value;

  late final _$hoursAtom =
      Atom(name: '_DurationInputStore.hours', context: context);

  @override
  int get hours {
    _$hoursAtom.reportRead();
    return super.hours;
  }

  @override
  set hours(int value) {
    _$hoursAtom.reportWrite(value, super.hours, () {
      super.hours = value;
    });
  }

  late final _$minutesAtom =
      Atom(name: '_DurationInputStore.minutes', context: context);

  @override
  int get minutes {
    _$minutesAtom.reportRead();
    return super.minutes;
  }

  @override
  set minutes(int value) {
    _$minutesAtom.reportWrite(value, super.minutes, () {
      super.minutes = value;
    });
  }

  late final _$secondsAtom =
      Atom(name: '_DurationInputStore.seconds', context: context);

  @override
  int get seconds {
    _$secondsAtom.reportRead();
    return super.seconds;
  }

  @override
  set seconds(int value) {
    _$secondsAtom.reportWrite(value, super.seconds, () {
      super.seconds = value;
    });
  }

  late final _$_DurationInputStoreActionController =
      ActionController(name: '_DurationInputStore', context: context);

  @override
  void updateHours(int value) {
    final _$actionInfo = _$_DurationInputStoreActionController.startAction(
        name: '_DurationInputStore.updateHours');
    try {
      return super.updateHours(value);
    } finally {
      _$_DurationInputStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMinutes(int value) {
    final _$actionInfo = _$_DurationInputStoreActionController.startAction(
        name: '_DurationInputStore.updateMinutes');
    try {
      return super.updateMinutes(value);
    } finally {
      _$_DurationInputStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateSeconds(int value) {
    final _$actionInfo = _$_DurationInputStoreActionController.startAction(
        name: '_DurationInputStore.updateSeconds');
    try {
      return super.updateSeconds(value);
    } finally {
      _$_DurationInputStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void init() {
    final _$actionInfo = _$_DurationInputStoreActionController.startAction(
        name: '_DurationInputStore.init');
    try {
      return super.init();
    } finally {
      _$_DurationInputStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
hours: ${hours},
minutes: ${minutes},
seconds: ${seconds},
totalDuration: ${totalDuration}
    ''';
  }
}
