import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/core/utils/app_colors.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/presentation/bloc/task_bloc.dart';
import 'package:seek/features/task/presentation/widgets/alert_form_widget.dart';
import 'package:seek/features/task/presentation/widgets/filter_widget.dart';
import 'package:seek/features/task/presentation/widgets/info_widget.dart';
import 'package:seek/features/task/presentation/widgets/search_widget.dart';
import 'package:seek/features/task/presentation/widgets/task_list_item_widget.dart';
import 'package:animation_list/animation_list.dart';

// Página principal que muestra la lista de tareas.
class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  final _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeInAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    GetIt.I<TaskBloc>().close();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showErrorAlert(context, state.error);
          });
        }
        if (state.status == TaskStatus.succes) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
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
                    ),
                  ),
                ],
              ),
              const InfoWidget(),
              Expanded(
                child: AnimationList(
                    key: UniqueKey(),
                    duration: 1500,
                    reBounceDepth: 30,
                    children: state.taskListFiltered.map((item) {
                      return TaskListItemWidget(
                        task: item,
                        onEditTap: () {
                          context
                              .read<TaskBloc>()
                              .add(SuccesTaskEvent(task: item));
                        },
                        onDeleteTap: () {
                          context
                              .read<TaskBloc>()
                              .add(DeleteTaskEvent(task: item));
                        },
                      );
                    }).toList()),
              ),
              const SizedBox(
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Desarrollado para Seek",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
      floatingActionButton: ScaleTransition(
        key: UniqueKey(),
        scale: _fadeInAnimation,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.add,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            _showAlertAddTask(context);
          },
        ),
      ),
    );
  }

  // Método para mostrar un diálogo de alerta para agregar una nueva tarea.
  void _showAlertAddTask(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertFormWidget(continueAction: (TaskModel task) {
          context.read<TaskBloc>().add(AddTaskEvent(task: task));
        });
      },
    );
  }

  // Método para mostrar un diálogo de alerta de error.
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
