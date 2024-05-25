import 'package:dartz/dartz.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/datasources/task_database_helper.dart';
import 'package:seek/features/task/data/datasources/task_datasource.dart';
import 'package:seek/features/task/data/models/task_model.dart';

// Fuente de datos local para operaciones relacionadas con tareas.
class TaskLocalDataSource implements TaskDatasource {
  final TaskDatabaseHelper _databaseHelper;

  TaskLocalDataSource(this._databaseHelper);

  // Agrega una tarea al origen de datos local.
  @override
  Future<Either<ErrorModel, List<TaskModel>>> addTask(TaskModel task) async {
    final result = await _databaseHelper.insertTask(task);
    return result.fold(
      (error) => Left(error),
      (_) async => await _databaseHelper.getAllTasks(),
    );
  }

  // Obtiene una lista de todas las tareas del origen de datos local.
  @override
  Future<Either<ErrorModel, List<TaskModel>>> getListTask() async {
    return await _databaseHelper.getAllTasks();
  }

  // Elimina una tarea del origen de datos local.
  @override
  Future<Either<ErrorModel, List<TaskModel>>> removeTask(TaskModel task) async {
    final result = await _databaseHelper.deleteTask(task);
    return result.fold(
      (error) => Left(error),
      (_) async => await _databaseHelper.getAllTasks(),
    );
  }

  // Edita una tarea en el origen de datos local.
  @override
  Future<Either<ErrorModel, List<TaskModel>>> editTask(TaskModel task) async {
    final result = await _databaseHelper.updateTask(task);
    return result.fold(
      (error) => Left(error),
      (_) async => await _databaseHelper.getAllTasks(),
    );
  }
}
