import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seek/features/task/data/datasources/task_database_helper.dart';
import 'package:seek/features/task/data/datasources/task_local_datasource.dart';
import 'package:seek/features/task/data/models/task_model.dart';

// Genera un archivo de Mock para TaskDatabaseHelper
@GenerateMocks([TaskDatabaseHelper])
import 'task_local_datasource_test.mocks.dart';

void main() {
  late TaskLocalDataSource dataSource;
  late MockTaskDatabaseHelper mockDatabaseHelper;

  setUp(() {
    // Inicializar el mock del helper de base de datos y el data source antes de cada prueba
    mockDatabaseHelper = MockTaskDatabaseHelper();
    dataSource = TaskLocalDataSource(mockDatabaseHelper);
  });

  // Datos de prueba
  final tTaskModel = TaskModel(
    id: 1,
    title: 'Test Task', // Título de la tarea de prueba
    description: 'Test Description', // Descripción de la tarea de prueba
    isComplete: 0,
  );
  final tTaskList = [tTaskModel];

  test('Agregar tarea a la base de datos.', () async {
    // Configurar el comportamiento del mock del helper de base de datos
    when(mockDatabaseHelper.insertTask(any))
        .thenAnswer((_) async => const Right(null));
    when(mockDatabaseHelper.getAllTasks())
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del data source
    final result = await dataSource.addTask(tTaskModel);

    // Verificar que se llamó al método correcto del helper de base de datos con el argumento correcto
    verify(mockDatabaseHelper.insertTask(tTaskModel));

    // Verificar que se llamó al método correcto del helper de base de datos para obtener todas las tareas
    verify(mockDatabaseHelper.getAllTasks());

    // Verificar que el resultado sea el esperado
    expect(result, Right(tTaskList));
  });

  test('Remover tarea de la base de datos.', () async {
    // Configurar el comportamiento del mock del helper de base de datos
    when(mockDatabaseHelper.deleteTask(any))
        .thenAnswer((_) async => const Right(null));
    when(mockDatabaseHelper.getAllTasks())
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del data source
    final result = await dataSource.removeTask(tTaskModel);

    // Verificar que se llamó al método correcto del helper de base de datos con el argumento correcto
    verify(mockDatabaseHelper.deleteTask(tTaskModel));

    // Verificar que se llamó al método correcto del helper de base de datos para obtener todas las tareas
    verify(mockDatabaseHelper.getAllTasks());

    // Verificar que el resultado sea el esperado
    expect(result, Right(tTaskList));
  });

  test('Listar tareas de la base de datos.', () async {
    // Configurar el comportamiento del mock del helper de base de datos
    when(mockDatabaseHelper.getAllTasks())
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del data source
    final result = await dataSource.getListTask();

    // Verificar que se llamó al método correcto del helper de base de datos para obtener todas las tareas
    verify(mockDatabaseHelper.getAllTasks());

    // Verificar que el resultado sea el esperado
    expect(result, Right(tTaskList));
  });

  test('Editar tareas de la base de datos.', () async {
    // Configurar el comportamiento del mock del helper de base de datos
    when(mockDatabaseHelper.updateTask(any))
        .thenAnswer((_) async => const Right(null));
    when(mockDatabaseHelper.getAllTasks())
        .thenAnswer((_) async => Right(tTaskList));

    // Ejecutar el método del data source
    final result = await dataSource.editTask(tTaskModel);

    // Verificar que se llamó al método correcto del helper de base de datos con el argumento correcto
    verify(mockDatabaseHelper.updateTask(tTaskModel));

    // Verificar que se llamó al método correcto del helper de base de datos para obtener todas las tareas
    verify(mockDatabaseHelper.getAllTasks());

    // Verificar que el resultado sea el esperado
    expect(result, Right(tTaskList));
  });
}
