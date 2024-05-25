import 'package:seek/features/task/data/models/task_model.dart';

// Fuente de datos abstracta para operaciones relacionadas con tareas.
abstract class TaskDatasource {
  // Método para obtener una lista de tareas.
  Future<List<TaskModel>> getListTask();

  // Método para agregar una nueva tarea.
  Future<List<TaskModel>> addTask(TaskModel task);

  // Método para eliminar una tarea.
  Future<List<TaskModel>> removeTask(TaskModel task);

  // Método para editar una tarea.
  Future<List<TaskModel>> editTask(TaskModel task);
}
