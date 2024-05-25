import 'package:dartz/dartz.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';

// Caso de uso para obtener una lista de tareas.
class ListTaskUseCase {
  final TaskRepository _taskRepository;

  // Constructor que recibe un repositorio de tareas.
  ListTaskUseCase(this._taskRepository);

  // Método para ejecutar el caso de uso y obtener la lista de tareas.
  Future<Either<ErrorModel, List<TaskModel>>> execute() {
    return _taskRepository.listTask();
  }
}
