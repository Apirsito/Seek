import 'package:dartz/dartz.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/datasources/task_local_datasource.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';

// Implementación concreta del repositorio de tareas.
class TaskRepositoryImpl implements TaskRepository {
  final TaskLocalDataSource _localDataSource;

  // Constructor que recibe un origen de datos local.
  TaskRepositoryImpl(this._localDataSource);

  @override
  Future<Either<ErrorModel, List<TaskModel>>> addTask(TaskModel task) async {
    // Agrega una tarea al origen de datos local y devuelve la lista actualizada.
    return await _localDataSource.addTask(task);
  }

  @override
  Future<Either<ErrorModel, List<TaskModel>>> deleteTask(TaskModel task) async {
    // Elimina una tarea del origen de datos local y devuelve la lista actualizada.
    return await _localDataSource.removeTask(task);
  }

  @override
  Future<Either<ErrorModel, List<TaskModel>>> listTask() async {
    // Obtiene la lista de tareas del origen de datos local.
    return await _localDataSource.getListTask();
  }

  @override
  Future<Either<ErrorModel, List<TaskModel>>> succesTask(TaskModel task) async {
    // Marca una tarea como exitosa en el origen de datos local y devuelve la lista actualizada.
    return await _localDataSource.editTask(task);
  }
}
