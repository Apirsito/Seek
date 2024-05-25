import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seek/features/task/data/datasources/task_local_datasource.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/data/repositories/task_repository_impl.dart';

// Genera un archivo de Mock para TaskLocalDataSource.
@GenerateMocks([TaskLocalDataSource])
import 'task_repository_impl_test.mocks.dart';

void main() {
  late TaskRepositoryImpl taskRepositoryImpl;
  late MockTaskLocalDataSource mockLocalDataSource;

  setUp(() {
    // Inicializar el mock del data source y el repositorio antes de cada prueba.
    mockLocalDataSource = MockTaskLocalDataSource();
    taskRepositoryImpl = TaskRepositoryImpl(mockLocalDataSource);
  });

  // Datos de prueba.
  final tTaskModel = TaskModel(
    id: 1,
    title: 'Tarea de Prueba',
    description: 'Descripción de Prueba',
    isComplete: 0,
  );
  final tTaskList = [tTaskModel];

  test('Agregar tarea', () async {
    // Configurar el comportamiento del mock del data source.
    when(mockLocalDataSource.addTask(any))
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del repositorio
    final result = await taskRepositoryImpl.addTask(tTaskModel);

    // Verificar que se llamó al método correcto del data source con el argumento correcto.
    verify(mockLocalDataSource.addTask(tTaskModel));

    // Verificar que el resultado sea el esperado.
    expect(result, Right(tTaskList));
  });

  test('Eliminar tarea', () async {
    // Configurar el comportamiento del mock del data source.
    when(mockLocalDataSource.removeTask(any))
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del repositorio.
    final result = await taskRepositoryImpl.deleteTask(tTaskModel);

    // Verificar que se llamó al método correcto del data source con el argumento correcto.
    verify(mockLocalDataSource.removeTask(tTaskModel));

    // Verificar que el resultado sea el esperado.
    expect(result, Right(tTaskList));
  });

  test('Listar tareas', () async {
    // Configurar el comportamiento del mock del data source.
    when(mockLocalDataSource.getListTask())
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del repositorio.
    final result = await taskRepositoryImpl.listTask();

    // Verificar que se llamó al método correcto del data source.
    verify(mockLocalDataSource.getListTask());

    // Verificar que el resultado sea el esperado.
    expect(result, Right(tTaskList));
  });

  test('Marcar tarea como exitosa', () async {
    // Configurar el comportamiento del mock del data source.
    when(mockLocalDataSource.editTask(any))
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del repositorio.
    final result = await taskRepositoryImpl.succesTask(tTaskModel);

    // Verificar que se llamó al método correcto del data source con el argumento correcto.
    verify(mockLocalDataSource.editTask(tTaskModel));

    // Verificar que el resultado sea el esperado.
    expect(result, Right(tTaskList));
  });
}
