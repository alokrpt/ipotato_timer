import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get_it/get_it.dart';

import '../../features/add_task/data/datasources/add_task_data_source.dart';
import '../../features/add_task/data/repositories/add_task_repository_impl.dart';
import '../../features/add_task/domain/repositories/add_task_repository.dart';
import '../../features/add_task/domain/usecases/add_task_use_case.dart';
import '../../features/add_task/presentation/pages/widgets/duration_input/duration_input_store.dart';
import '../../features/add_task/presentation/store/add_task_store.dart';
import '../../features/task_item/data/datasources/task_item_data_source.dart';
import '../../features/task_item/data/repositories/task_item_repository_impl.dart';
import '../../features/task_item/domain/repositories/task_item_repository.dart';
import '../../features/task_item/domain/usecases/delete_task_use_case.dart';
import '../../features/task_item/domain/usecases/update_task_use_case.dart';
import '../../features/task_item/presentation/store/task_item_store.dart';
import '../../features/task_list/data/datasources/task_list_data_source.dart';
import '../../features/task_list/data/repositories/task_list_repository_impl.dart';
import '../../features/task_list/domain/repositories/task_list_repository.dart';
import '../../features/task_list/domain/usecases/task_list_use_case.dart';
import '../../features/task_list/presentation/store/task_list_store.dart';
import '../audio/audio_player.dart';
import '../audio/audio_player_impl.dart';
import '../data/data_source/data_source_client.dart';
import '../data/data_source/data_source_client_impl.dart';
import '../data/database/app_database.dart';

final sl = GetIt.instance;

Future<void> initDependencyInjection() async {
  // Store
  _storeSl();

  // Data sources
  _dataSourcesSl();

  // Repository
  _repositorySl();

  // Use cases
  _useCasesSl();

  // Core
  _coreSl();
}

void _storeSl() {
  sl.registerLazySingleton(
    () => DurationInputStore(),
  );
  sl.registerLazySingleton(
    () => AddTaskStore(sl()),
  );
  sl.registerLazySingleton(
    () => TaskListStore(sl()),
  );
  sl.registerLazySingleton(
    () => TaskItemStore(
      deleteTaskUseCase: sl(),
      updateTaskUseCase: sl(),
      audioPlayer: sl(),
    ),
  );
}

void _dataSourcesSl() {
  sl.registerLazySingleton<AddTaskDataSource>(
    () => AddTaskDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<TaskListDataSource>(
    () => TaskListDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<TaskItemDataSource>(
    () => TaskItemDataSourceImpl(sl()),
  );
}

void _repositorySl() {
  sl.registerLazySingleton<AddTaskRepository>(
    () => AddTaskRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<TaskListRepository>(
    () => TaskListRepositoryImpl(dataSource: sl()),
  );
  sl.registerLazySingleton<TaskItemRepository>(
    () => TaskItemRepositoryImpl(dataSource: sl()),
  );
}

void _useCasesSl() {
  sl.registerLazySingleton(
    () => AddTaskUseCase(sl()),
  );

  sl.registerLazySingleton(
    () => TaskListUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => DeleteTaskUseCase(sl()),
  );
  sl.registerLazySingleton(
    () => UpdateTaskUseCase(sl()),
  );
}

void _coreSl() {
  sl.registerLazySingleton<DataSourceClient>(
    () => DataSourceClientImpl(sl()),
  );
  sl.registerSingletonAsync<AppDatabase>(() async {
    return AppDatabase();
  });
  sl.registerSingletonAsync<AudioPlayer>(() async {
    return AudioPlayerImpl(
      audio: Audio('assets/audio/betty_boop_tune.mp3'),
      audioPlayer: AssetsAudioPlayer(),
    );
  });
}
