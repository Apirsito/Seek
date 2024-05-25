part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class ListTaskEvent extends TaskEvent {
  const ListTaskEvent();
}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;
  const AddTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final TaskModel task;
  const DeleteTaskEvent({required this.task});
}

class SuccesTaskEvent extends TaskEvent {
  final TaskModel task;
  const SuccesTaskEvent({required this.task});
}

class FilterTaskEvent extends TaskEvent {
  final int value;
  final List<TaskModel> listTaskFull;
  const FilterTaskEvent({required this.value, required this.listTaskFull});
}

class SearchTaskEvent extends TaskEvent {
  final String value;
  final List<TaskModel> listTaskFull;
  final int filterValue;
  const SearchTaskEvent(
      {required this.value,
      required this.listTaskFull,
      required this.filterValue});
}
