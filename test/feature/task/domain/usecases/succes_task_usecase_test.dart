import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/repositories/task_repository.dart';
import 'package:seek/features/task/domain/usecases/succes_task_usecase.dart';

// Genera un archivo de Mock para TaskRepository
@GenerateMocks([TaskRepository])
import 'succes_task_usecase_test.mocks.dart';

void main() {
  late SuccesTaskUseCase succesTaskUseCase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    // Inicializar el mock y el caso de uso antes de cada prueba.
    mockTaskRepository = MockTaskRepository();
    succesTaskUseCase = SuccesTaskUseCase(mockTaskRepository);
  });

  // Datos de prueba.
  final tTaskModel = TaskModel(
    id: 1,
    title: 'Test Task',
    description: 'Test Description',
    isComplete: 0,
  );
  final tTaskList = [tTaskModel];

  test('Marcar tarea como realizada.', () async {
    // Configurar el comportamiento del mock.
    when(mockTaskRepository.succesTask(any))
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el caso de uso.
    final result = await succesTaskUseCase.execute(tTaskModel);

    // Verificar el resultado.
    result.fold(
      (error) => fail('No se esperaba un error: $error'),
      (taskList) => expect(taskList, tTaskList),
    );
    verify(mockTaskRepository.succesTask(tTaskModel)).called(1);
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
