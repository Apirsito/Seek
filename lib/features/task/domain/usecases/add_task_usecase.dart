import 'package:dartz/dartz.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/task_usecase.dart';

// Caso de uso para agregar una nueva tarea.
class AddTaskUseCase extends TaskUseCase<TaskModel> {
  final TaskRepository _taskRepository;

  // Constructor que recibe un repositorio de tareas.
  AddTaskUseCase(this._taskRepository);

  // Método para ejecutar el caso de uso y agregar una nueva tarea.
  @override
  Future<Either<ErrorModel, List<TaskModel>>> execute(TaskModel parameter) {
    return _taskRepository.addTask(parameter);
  }
}
