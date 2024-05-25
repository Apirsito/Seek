import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/task_usecase.dart';

// Caso de uso para eliminar una tarea.
class DeleteTaskUseCase extends TaskUseCase<TaskModel> {
  final TaskRepository _taskRepostory;

  // Constructor que recibe un repositorio de tareas.
  DeleteTaskUseCase(this._taskRepostory);

  // Método para ejecutar el caso de uso y eliminar la tarea.
  @override
  Future<List<TaskModel>> execute(TaskModel parameter) {
    return _taskRepostory.deleteTask(parameter);
  }
}
