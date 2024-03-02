import 'package:mobx/mobx.dart';

class DurationInputStore = _DurationInputStore with _$DurationInputStore;

abstract class _DurationInputStore with Store {
  @observable
  int hours = 0;

  @observable
  int minutes = 0;

  @observable
  int seconds = 0;

  @computed
  Duration get totalDuration =>
      Duration(hours: hours, minutes: minutes, seconds: seconds);

  @action
  void updateHours(int value) {
    hours = value;
  }

  @action
  void updateMinutes(int value) {
    minutes = value;
  }

  @action
  void updateSeconds(int value) {
    seconds = value;
  }
}
