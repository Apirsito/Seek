import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/task_usecase.dart';

// Caso de uso para realizar una tarea exitosa.
class SuccesTaskUseCase extends TaskUseCase<TaskModel> {
  final TaskRepository _taskRepostory;

  // Constructor que recibe un repositorio de tareas.
  SuccesTaskUseCase(this._taskRepostory);

  // Implementación del método execute para ejecutar el caso de uso.
  @override
  Future<List<TaskModel>> execute(TaskModel parameter) {
    return _taskRepostory.succesTask(parameter);
  }
}
