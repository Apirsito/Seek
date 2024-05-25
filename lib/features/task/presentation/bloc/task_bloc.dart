import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/domain/usecases/add_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/list_task_usecase.dart';
import 'package:seek/features/task/domain/usecases/succes_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final ListTaskUseCase _listTaskUseCase;
  final AddTaskUseCase _addTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final SuccesTaskUseCase _succesTaskUseCase;
  TaskBloc({
    required ListTaskUseCase listTaskUseCase,
    required AddTaskUseCase addTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
    required SuccesTaskUseCase succesTaskUseCase,
  })  : _listTaskUseCase = listTaskUseCase,
        _addTaskUseCase = addTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _succesTaskUseCase = succesTaskUseCase,
        super(const TaskState()) {
    on<ListTaskEvent>(_listTask);
    on<AddTaskEvent>(_addTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SuccesTaskEvent>(_succesTask);
    on<FilterTaskEvent>(_filterTask);
    on<SearchTaskEvent>(_searchTask);
  }

  //Listar tareas.
  Future<void> _listTask(ListTaskEvent event, Emitter<TaskState> emit) async {
    final result = await _listTaskUseCase.execute();
    result.fold(
      (error) => emit(state.copyWith(status: TaskStatus.error, error: error)),
      (listTask) => emit(state.copyWith(
        taskList: listTask,
        taskListFiltered: listTask,
        filterValue: -1,
        status: TaskStatus.succes,
      )),
    );
  }

  //Agregar tarea.
  Future<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    final result = await _addTaskUseCase.execute(event.task);
    result.fold(
      (error) => emit(state.copyWith(status: TaskStatus.error, error: error)),
      (listTask) => emit(state.copyWith(
        taskList: listTask,
        taskListFiltered: listTask,
        filterValue: -1,
      )),
    );
  }

  //Remover tarea.
  Future<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final result = await _deleteTaskUseCase.execute(event.task);
    result.fold(
      (error) => emit(state.copyWith(status: TaskStatus.error, error: error)),
      (listTask) => emit(state.copyWith(
        taskList: listTask,
        taskListFiltered: listTask,
        filterValue: -1,
      )),
    );
  }

  //Completar tarea.
  Future<void> _succesTask(
      SuccesTaskEvent event, Emitter<TaskState> emit) async {
    event.task.isComplete = 1;
    final result = await _succesTaskUseCase.execute(event.task);
    result.fold(
      (error) => emit(state.copyWith(status: TaskStatus.error, error: error)),
      (listTask) => emit(state.copyWith(
        taskList: listTask,
        taskListFiltered: listTask,
        filterValue: -1,
      )),
    );
  }

  //Filtrar tarea.
  FutureOr<void> _filterTask(
      FilterTaskEvent event, Emitter<TaskState> emit) async {
    // emit(state.copyWith(filterValue: event.value));
    if (event.value != -1) {
      List<TaskModel> listFiltered = event.listTaskFull
          .where((task) => task.isComplete == event.value)
          .toList();

      emit(state.copyWith(
          taskListFiltered: listFiltered, filterValue: event.value));
    } else {
      emit(state.copyWith(
          taskListFiltered: event.listTaskFull, filterValue: event.value));
    }
  }

  //buscar tarea.
  FutureOr<void> _searchTask(
      SearchTaskEvent event, Emitter<TaskState> emit) async {
    List<TaskModel> listFiltered = [];
    if (event.filterValue != -1) {
      listFiltered = event.listTaskFull
          .where((task) => task.isComplete == event.filterValue)
          .toList();
    } else {
      listFiltered = event.listTaskFull;
    }
    if (event.value != "") {
      List<TaskModel> listSearch = listFiltered
          .where((task) =>
              task.title.toLowerCase().contains(event.value.toLowerCase()) ||
              task.description
                  .toLowerCase()
                  .contains(event.value.toLowerCase()))
          .toList();

      emit(state.copyWith(
          taskListFiltered: listSearch, searchValue: event.value));
    } else {
      emit(state.copyWith(
          taskListFiltered: listFiltered, searchValue: event.value));
    }
  }
}
