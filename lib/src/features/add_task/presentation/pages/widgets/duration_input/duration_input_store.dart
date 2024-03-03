import 'package:mobx/mobx.dart';

part 'duration_input_store.g.dart';

class DurationInputStore extends _DurationInputStore with _$DurationInputStore {
  DurationInputStore();
}
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

  @action
  void init() {
    hours = 0;
    minutes = 0;
    seconds = 0;
  }
}
