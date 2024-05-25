import 'package:seek/features/task/data/models/task_model.dart';

// Repositorio abstracto para operaciones relacionadas con tareas.
abstract class TaskRepository {
  // Método para obtener una lista de tareas.
  Future<List<TaskModel>> listTask();

  // Método para agregar una nueva tarea.
  Future<List<TaskModel>> addTask(TaskModel task);

  // Método para eliminar una tarea.
  Future<List<TaskModel>> deleteTask(TaskModel task);

  // Método para marcar una tarea como exitosa.
  Future<List<TaskModel>> succesTask(TaskModel task);
}
