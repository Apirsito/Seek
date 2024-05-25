import 'package:get_it/get_it.dart';
import 'package:seek/features/task/data/datasources/task_database_helper.dart';
import 'package:seek/features/task/data/datasources/task_local_datasource.dart';
import 'package:seek/features/task/data/repositories/task_repository_impl.dart';
import 'package:seek/features/task/domain/usecases/add_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/list_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/succes_task_usecase.dart';
import '../../features/task/presentation/bloc/task_bloc.dart';

// Configuración de las dependencias de la aplicación.
void configureDependencies() {
  // Instancia de GetIt
  final getIt = GetIt.instance;

  // Registro de la base de datos.
  getIt.registerSingleton<TaskDatabaseHelper>(TaskDatabaseHelper());

  // Registro del datasource local.
  getIt.registerLazySingleton(
      () => TaskLocalDataSource(getIt.get<TaskDatabaseHelper>()));

  // Registro de la implementación del repositorio.
  getIt.registerLazySingleton<TaskRepositoryImpl>(
      () => TaskRepositoryImpl(getIt<TaskLocalDataSource>()));

  // Registro de los casos de uso.
  getIt.registerLazySingleton(
      () => ListTaskUseCase(getIt<TaskRepositoryImpl>()));
  getIt
      .registerLazySingleton(() => AddTaskUseCase(getIt<TaskRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => DeleteTaskUseCase(getIt<TaskRepositoryImpl>()));
  getIt.registerLazySingleton(
      () => SuccesTaskUseCase(getIt<TaskRepositoryImpl>()));

  // Registro del Bloc de tareas.
  getIt.registerFactory(() => TaskBloc(
        listTaskUseCase: getIt<ListTaskUseCase>(),
        addTaskUseCase: getIt<AddTaskUseCase>(),
        deleteTaskUseCase: getIt<DeleteTaskUseCase>(),
        succesTaskUseCase: getIt<SuccesTaskUseCase>(),
      ));
}
