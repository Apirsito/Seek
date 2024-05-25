import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/list_task_usecase.dart';

// Genera un archivo de Mock para TaskRepository
@GenerateMocks([TaskRepository])
import 'list_task_usecase_test.mocks.dart';

void main() {
  late ListTaskUseCase listTaskUseCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    // Inicializar el mock y el caso de uso antes de cada prueba.
    mockTaskRepository = MockTaskRepository();
    listTaskUseCase = ListTaskUseCase(mockTaskRepository);
  });

  // Datos de prueba
  final tTaskList = [
    TaskModel(
        id: 1, title: 'Task 1', description: 'Description 1', isComplete: 0),
    TaskModel(
        id: 2, title: 'Task 2', description: 'Description 2', isComplete: 1),
    TaskModel(
        id: 3, title: 'Task 3', description: 'Description 3', isComplete: 0),
  ];

  test('Listar tarea', () async {
    // Configurar el comportamiento del mock.
    when(mockTaskRepository.listTask())
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el caso de uso.
    final result = await listTaskUseCase.execute();

    // Verificar el resultado.
    expect(result, Right(tTaskList));
    verify(mockTaskRepository.listTask());
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
