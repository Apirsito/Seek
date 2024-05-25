import 'package:seek/features/task/data/models/task_model.dart';

// Interfaz para casos de uso de tareas.
abstract class TaskUseCase<T> {
  // Método para ejecutar el caso de uso y obtener una lista de modelos de tareas.
  Future<List<TaskModel>> execute(T parameter);
}
