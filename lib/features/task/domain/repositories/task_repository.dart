import 'package:dartz/dartz.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/models/task_model.dart';

// Repositorio abstracto para operaciones relacionadas con tareas.
abstract class TaskRepository {
  // Método para obtener una lista de tareas.
  Future<Either<ErrorModel, List<TaskModel>>> listTask();

  // Método para agregar una nueva tarea.
  Future<Either<ErrorModel, List<TaskModel>>> addTask(TaskModel task);

  // Método para eliminar una tarea.
  Future<Either<ErrorModel, List<TaskModel>>> deleteTask(TaskModel task);

  // Método para marcar una tarea como exitosa.
  Future<Either<ErrorModel, List<TaskModel>>> succesTask(TaskModel task);
}
