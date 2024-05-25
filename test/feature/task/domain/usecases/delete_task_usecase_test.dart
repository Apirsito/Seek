import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/delete_task_usecase.dart';

// Genera un archivo de Mock para TaskRepository
@GenerateMocks([TaskRepository])
import 'delete_task_usecase_test.mocks.dart';

void main() {
  late DeleteTaskUseCase deleteTaskUseCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    // Inicializar el mock y el caso de uso antes de cada prueba
    mockTaskRepository = MockTaskRepository();
    deleteTaskUseCase = DeleteTaskUseCase(mockTaskRepository);
  });

  // Datos de prueba
  final tTaskModel = TaskModel(
    id: 1,
    title: 'Test Task',
    description: 'Test Description',
    isComplete: 0,
  );
  final tTaskList = [tTaskModel];

  test('Borrar tarea', () async {
    // Configurar el comportamiento del mock
    when(mockTaskRepository.deleteTask(any)).thenAnswer((_) async => tTaskList);

    // Ejecutar el caso de uso
    final result = await deleteTaskUseCase.execute(tTaskModel);

    // Verificar el resultado
    expect(result, tTaskList);
    verify(mockTaskRepository.deleteTask(tTaskModel));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
