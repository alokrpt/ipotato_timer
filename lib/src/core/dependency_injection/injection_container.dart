import 'package:get_it/get_it.dart';
import 'package:ipotato_timer/src/core/database/data_source_client.dart';
import 'package:ipotato_timer/src/core/database/data_source_client_impl.dart';
import 'package:ipotato_timer/src/features/add_task/presentation/pages/widgets/duration_input/duration_input_store.dart';

import '../../features/add_task/data/datasources/add_task_data_source.dart';
import '../../features/add_task/data/repositories/add_task_repository_impl.dart';
import '../../features/add_task/domain/repositories/add_task_repository.dart';
import '../../features/add_task/domain/usecases/add_task_use_case.dart';
import '../../features/add_task/presentation/store/add_task_store.dart';

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
}

void _dataSourcesSl() {
  sl.registerLazySingleton<AddTaskDataSource>(
    () => AddTaskDataSourceImpl(sl()),
  );
}

void _repositorySl() {
  sl.registerLazySingleton<AddTaskRepository>(
    () => AddTaskRepositoryImpl(dataSource: sl()),
  );
}

void _useCasesSl() {
  sl.registerLazySingleton<AddTaskUseCase>(
    () => AddTaskUseCase(sl()),
  );
}

void _coreSl() {
  sl.registerLazySingleton<DataSourceClient>(
    () => DataSourceClientImpl(),
  );
}
