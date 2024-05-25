import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/core/utils/app_colors.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/presentation/bloc/task_bloc.dart';
import 'package:seek/features/task/presentation/widgets/alert_widget.dart';
import 'package:seek/features/task/presentation/widgets/filter_widget.dart';
import 'package:seek/features/task/presentation/widgets/search_widget.dart';
import 'package:seek/features/task/presentation/widgets/task_list_item_widget.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          "Lista de tareas",
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
        if (state.status == TaskStatus.initial) {
          context.read<TaskBloc>().add(const ListTaskEvent());
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == TaskStatus.error) {
          _showErrorAlert(context, state.error);
        }
        if (state.status == TaskStatus.succes) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SearchWidget(
                      controller: _controller,
                      onchange: (String value) {
                        context.read<TaskBloc>().add(SearchTaskEvent(
                            value: value,
                            listTaskFull: state.taskList,
                            filterValue: state.filterValue));
                      },
                    ),
                  ),
                  FittedBox(
                      child: FilterWidget(
                    onchange: (int? value) {
                      context.read<TaskBloc>().add(FilterTaskEvent(
                          value: value ?? -1, listTaskFull: state.taskList));
                      _controller.text = "";
                    },
                    value: state.filterValue,
                  )),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.taskListFiltered.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskListItemWidget(
                        task: state.taskListFiltered[index],
                        onEditTap: () {
                          context.read<TaskBloc>().add(SuccesTaskEvent(
                              task: state.taskListFiltered[index]));
                        },
                        onDeleteTap: () {
                          context.read<TaskBloc>().add(DeleteTaskEvent(
                              task: state.taskListFiltered[index]));
                        });
                  },
                ),
              ),
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showAlertAddTask(context);
          }),
    );
  }

  void _showAlertAddTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(continueAction: (TaskModel task) {
          context.read<TaskBloc>().add(AddTaskEvent(task: task));
        });
      },
    );
  }

  void _showErrorAlert(BuildContext context, ErrorModel error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(error.description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
