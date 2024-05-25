part of 'task_bloc.dart';

enum TaskStatus {
  initial,
  loading,
  succes,
  error,
}

class TaskState extends Equatable {
  final List<TaskModel> taskList;
  final List<TaskModel> taskListFiltered;
  final TaskStatus status;
  final double valueX;
  final int filterValue;
  final String searchValue;

  const TaskState({
    this.taskList = const [],
    this.taskListFiltered = const [],
    this.status = TaskStatus.initial,
    this.valueX = 0,
    this.filterValue = -1,
    this.searchValue = "",
  });

  @override
  List<Object?> get props =>
      [taskList, taskListFiltered, status, valueX, filterValue, searchValue];

  TaskState copyWith({
    List<TaskModel>? taskList,
    List<TaskModel>? taskListFiltered,
    TaskStatus? status,
    double? valueX,
    int? filterValue,
    String? searchValue,
  }) {
    return TaskState(
      taskList: taskList ?? this.taskList,
      taskListFiltered: taskListFiltered ?? this.taskListFiltered,
      status: status ?? this.status,
      valueX: valueX ?? this.valueX,
      filterValue: filterValue ?? this.filterValue,
      searchValue: searchValue ?? this.searchValue,
    );
  }
}
