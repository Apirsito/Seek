import 'package:flutter/material.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:seek/features/task/presentation/widgets/alert_widget.dart';
import 'package:seek/features/task/presentation/widgets/popup_menu_button_widget.dart';

// Widget que muestra un elemento de lista de tarea.
class TaskListItemWidget extends StatelessWidget {
  // Tarea asociada con este elemento de la lista.
  final TaskModel task;

  // Callback que se llama cuando se toca el botón de edición.
  final VoidCallback onEditTap;

  // Callback que se llama cuando se toca el botón de eliminación.
  final VoidCallback onDeleteTap;

  // Constructor que requiere la tarea, así como las funciones de edición y eliminación.
  const TaskListItemWidget({
    Key? key,
    required this.task,
    required this.onEditTap,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: task.isComplete == 0
            ? Colors.white
            : const Color.fromARGB(255, 19, 173, 135),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Icon(
              Icons.event,
              color: task.isComplete == 1 ? Colors.white : Colors.black,
              size: 30,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: task.isComplete == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 17,
                      color: task.isComplete == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              // Widget de menú emergente para opciones de tarea.
              PopupMenuButtonWidget(
                onSuccess: () {
                  // Muestra un diálogo de alerta para confirmar la finalización de la tarea.
                  _showAlert(
                    context: context,
                    title: "Advertencia",
                    description: "¿Finalizaste la tarea?",
                    action: onEditTap,
                  );
                },
                onDelete: () {
                  // Muestra un diálogo de alerta para confirmar la eliminación de la tarea.
                  _showAlert(
                    context: context,
                    title: "Advertencia",
                    description: "¿Estás seguro de borrar esta actividad?",
                    action: onDeleteTap,
                  );
                },
                isComplete: task.isComplete,
              ),
            ],
          )
        ],
      ),
    );
  }

  // Método privado para mostrar un diálogo de alerta.
  void _showAlert({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback action,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
          title: title,
          description: description,
          action: action,
        );
      },
    );
  }
}
