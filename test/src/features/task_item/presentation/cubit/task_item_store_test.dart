import 'package:flutter_test/flutter_test.dart';
import 'package:ipotato_timer/src/core/audio/audio_player.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/delete_task_use_case.dart';
import 'package:ipotato_timer/src/features/task_item/domain/usecases/update_task_use_case.dart';
import 'package:ipotato_timer/src/features/task_item/presentation/store/task_item_store.dart';
import 'package:mockito/annotations.dart';

import 'task_item_store_test.mocks.dart';

@GenerateMocks([
  UpdateTaskUseCase,
  DeleteTaskUseCase,
  AudioPlayer,
])
void main() {
  late MockUpdateTaskUseCase updateTaskUseCase;
  late MockDeleteTaskUseCase deleteTaskUseCase;
  late MockAudioPlayer audioPlayer;
  late TaskItemStore store;

  setUp(() {
    updateTaskUseCase = MockUpdateTaskUseCase();
    deleteTaskUseCase = MockDeleteTaskUseCase();
    audioPlayer = MockAudioPlayer();
    store = TaskItemStore(
      audioPlayer: audioPlayer,
      deleteTaskUseCase: deleteTaskUseCase,
      updateTaskUseCase: updateTaskUseCase,
    );
  });

  group('task_item', () {
    test(
      'should return initial state',
      () => expect(store.remainingDuration, const Duration(seconds: -1)),
    );
  });
}
