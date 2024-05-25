import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:seek/features/task/data/models/task_model.dart';

import 'package:seek/features/task/domain/usecases/add_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/list_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/succes_task_usecase.dart';
import 'package:seek/features/task/presentation/bloc/task_bloc.dart';

// Genera un archivo de Mock para las dependencias del BLoC
@GenerateMocks([
  ListTaskUseCase,
  AddTaskUseCase,
  DeleteTaskUseCase,
  SuccesTaskUseCase,
])
import 'task_bloc_test.mocks.dart';

void main() {
  group('TaskBloc', () {
    late TaskBloc taskBloc;
    late MockListTaskUseCase mockListTaskUseCase;
    late MockAddTaskUseCase mockAddTaskUseCase;
    late MockDeleteTaskUseCase mockDeleteTaskUseCase;
    late MockSuccesTaskUseCase mockSuccesTaskUseCase;

    setUp(() {
      // Configurar el mock de los casos de uso.
      mockListTaskUseCase = MockListTaskUseCase();
      mockAddTaskUseCase = MockAddTaskUseCase();
      mockDeleteTaskUseCase = MockDeleteTaskUseCase();
      mockSuccesTaskUseCase = MockSuccesTaskUseCase();

      // Inicializar el BLoC con los mocks de los casos de uso.
      taskBloc = TaskBloc(
        listTaskUseCase: mockListTaskUseCase,
        addTaskUseCase: mockAddTaskUseCase,
        deleteTaskUseCase: mockDeleteTaskUseCase,
        succesTaskUseCase: mockSuccesTaskUseCase,
      );
    });

    tearDown(() {
      // Liberar recursos después de cada prueba.
      taskBloc.close();
    });

    // Test para el evento ListTaskEvent.
    test('Emitir evento cuando se consuma la lista.', () async {
      final tTaskList = [
        TaskModel(
            id: 1,
            title: 'Test Task',
            description: 'Test Description',
            isComplete: 0)
      ];

      // Configurar el comportamiento del mock del caso de uso ListTaskUseCase.
      when(mockListTaskUseCase.execute())
          .thenAnswer((_) async => Right(tTaskList));

      // Emitir el evento ListTaskEvent.
      taskBloc.add(const ListTaskEvent());

      // Verificar que el BLoC emite un estado con la lista de tareas esperada.
      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>().having((state) {
            return state.taskList;
          }, 'task list', tTaskList)
        ]),
      );
    });
    test('Emitir estado al agregar tarea.', () async {
      final tTaskList = [
        TaskModel(
          id: 1,
          title: 'Test Task',
          description: 'Test Description',
          isComplete: 0,
        )
      ];
      final tTaskToAdd = TaskModel(
        id: 2,
        title: 'New Task',
        description: 'New Description',
        isComplete: 0,
      );
      when(mockAddTaskUseCase.execute(any))
          .thenAnswer((_) async => Right(tTaskList));

      taskBloc.add(AddTaskEvent(task: tTaskToAdd));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>()
              .having((state) => state.taskList, 'task list', tTaskList)
        ]),
      );
    });

    test('Emitir estado cuando es eliminada alguna tarea.', () async {
      final tTaskList = [
        TaskModel(
          id: 1,
          title: 'Test Task',
          description: 'Test Description',
          isComplete: 0,
        )
      ];
      final tTaskToDelete = TaskModel(
        id: 1,
        title: 'Test Task',
        description: 'Test Description',
        isComplete: 0,
      );
      when(mockDeleteTaskUseCase.execute(any))
          .thenAnswer((_) async => Right(tTaskList));

      taskBloc.add(DeleteTaskEvent(task: tTaskToDelete));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>()
              .having((state) => state.taskList, 'task list', tTaskList)
        ]),
      );
    });

    test('Emitir estado al pasar como exitosa la tarea.', () async {
      final tTaskList = [
        TaskModel(
          id: 1,
          title: 'Test Task',
          description: 'Test Description',
          isComplete: 1, // Task completed
        )
      ];
      final tTaskToComplete = TaskModel(
        id: 1,
        title: 'Test Task',
        description: 'Test Description',
        isComplete: 0, // Task incomplete
      );
      when(mockSuccesTaskUseCase.execute(any))
          .thenAnswer((_) async => Right(tTaskList));

      taskBloc.add(SuccesTaskEvent(task: tTaskToComplete));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>()
              .having((state) => state.taskList, 'task list', tTaskList)
        ]),
      );
    });

    test('Emitir estado cuando se filtre la lista.', () async {
      final tasks = [
        TaskModel(
            id: 1,
            title: 'Task 1',
            description: 'Description 1',
            isComplete: 0),
        TaskModel(
            id: 2,
            title: 'Task 2',
            description: 'Description 2',
            isComplete: 1),
        TaskModel(
            id: 3,
            title: 'Task 3',
            description: 'Description 3',
            isComplete: 0),
      ];

      taskBloc.add(FilterTaskEvent(value: 0, listTaskFull: tasks));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>().having((state) {
            return state.taskListFiltered.length;
          }, 'filterTask', 2)
        ]),
      );
    });

    test('Emitir estado cuando se haga una busqueda en la lista', () async {
      final tasks = [
        TaskModel(
            id: 1,
            title: 'Task 1',
            description: 'Description 1',
            isComplete: 0),
        TaskModel(
            id: 2,
            title: 'Task 2',
            description: 'Description 2',
            isComplete: 1),
        TaskModel(
            id: 3,
            title: 'Task 3',
            description: 'Description 3',
            isComplete: 0),
      ];

      taskBloc.add(
          SearchTaskEvent(value: "3", listTaskFull: tasks, filterValue: -1));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>().having((state) {
            return state.taskListFiltered.length;
          }, 'filterTask', 1)
        ]),
      );
    });

    test('Emitir estado cuando cambie la variable de la animacion.', () async {
      const tValueX = 1000.0;
      taskBloc.add(const ChangeValueAnimationX(valueX: tValueX));

      await expectLater(
        taskBloc.stream,
        emitsInOrder([
          isA<TaskState>().having((state) => state.valueX, 'valueX', tValueX)
        ]),
      );
    });
  });
}
