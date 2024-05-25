import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';

// Caso de uso para obtener una lista de tareas.
class ListTaskUseCase {
  final TaskRepository _taskRepostory;

  // Constructor que recibe un repositorio de tareas.
  ListTaskUseCase(this._taskRepostory);

  // Método para ejecutar el caso de uso y obtener la lista de tareas.
  Future<List<TaskModel>> execute() {
    return _taskRepostory.listTask();
  }
}
