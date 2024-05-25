import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<ChangeValueAnimationX>(_changeValueX);
  }

  //Listar tareas.
  FutureOr<void> _listTask(ListTaskEvent event, Emitter<TaskState> emit) async {
    List<TaskModel> listTask = await _listTaskUseCase.execute();
    emit(state.copyWith(
        taskList: listTask,
        taskListFiltered: listTask,
        filterValue: -1,
        status: TaskStatus.succes));
  }

  //Agregar tarea.
  FutureOr<void> _addTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    List<TaskModel> listTask = await _addTaskUseCase.execute(event.task);
    emit(state.copyWith(
        taskList: listTask, taskListFiltered: listTask, filterValue: -1));
  }

  //Remover tarea.
  FutureOr<void> _deleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    List<TaskModel> listTask = await _deleteTaskUseCase.execute(event.task);
    emit(state.copyWith(
        taskList: listTask, taskListFiltered: listTask, filterValue: -1));
  }

  //Completar tarea.
  FutureOr<void> _succesTask(
      SuccesTaskEvent event, Emitter<TaskState> emit) async {
    event.task.isComplete = 1;
    List<TaskModel> listTask = await _succesTaskUseCase.execute(event.task);
    emit(state.copyWith(
        taskList: listTask, taskListFiltered: listTask, filterValue: -1));
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
    if (event.value != "") {
      List<TaskModel> listFiltered = [];
      if (event.filterValue != -1) {
        listFiltered = event.listTaskFull
            .where((task) => task.isComplete == event.filterValue)
            .toList();
      } else {
        listFiltered = event.listTaskFull;
      }

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
          taskListFiltered: state.taskList, searchValue: event.value));
    }
  }

  FutureOr<void> _changeValueX(
      ChangeValueAnimationX event, Emitter<TaskState> emit) {
    emit(state.copyWith(valueX: event.valueX));
  }
}
