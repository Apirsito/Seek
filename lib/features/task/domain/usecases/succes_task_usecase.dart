import 'package:dartz/dartz.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/task_usecase.dart';

// Caso de uso para realizar una tarea exitosa.
class SuccesTaskUseCase extends TaskUseCase<TaskModel> {
  final TaskRepository _taskRepository;

  // Constructor que recibe un repositorio de tareas.
  SuccesTaskUseCase(this._taskRepository);

  // Método para ejecutar el caso de uso y realizar una tarea exitosa.
  @override
  Future<Either<ErrorModel, List<TaskModel>>> execute(TaskModel parameter) {
    return _taskRepository.succesTask(parameter);
  }
}
