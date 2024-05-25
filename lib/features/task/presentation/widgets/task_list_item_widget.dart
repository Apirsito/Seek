import 'package:flutter/material.dart';
import 'package:seek/features/task/data/models/task_model.dart';

class TaskListItemWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const TaskListItemWidget({
    Key? key,
    required this.task,
    required this.onEditTap,
    required this.onDeleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: task.isComplete == 0
              ? const Color.fromARGB(255, 255, 255, 255)
              : Color.fromARGB(255, 221, 247, 222),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Color de la sombra
              spreadRadius: 1, // Radio de difuminado
              blurRadius: 1, // Radio de borrosidad
              offset: const Offset(0, 0), // Desplazamiento de la sombra
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(task.description),
              ],
            ),
          ),
          Row(
            children: [
              task.isComplete == 0
                  ? IconButton(
                      icon: const Icon(Icons.check),
                      color: Colors.green,
                      onPressed: onEditTap,
                    )
                  : SizedBox(),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: onDeleteTap,
                color: Colors.redAccent,
              ),
            ],
          )
        ],
      ),
    );
  }
}
