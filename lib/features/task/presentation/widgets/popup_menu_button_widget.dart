import 'package:flutter/material.dart';

// Widget que muestra un menú emergente con opciones para completar o eliminar una tarea.
class PopupMenuButtonWidget extends StatelessWidget {
  // Estado de completitud de la tarea (0 para incompleta, 1 para completa).
  final int isComplete;

  // Callback que se llama al seleccionar la opción de completar tarea.
  final VoidCallback onSuccess;

  // Callback que se llama al seleccionar la opción de eliminar tarea.
  final VoidCallback onDelete;

  // Constructor que requiere las funciones de éxito y eliminación, así como el estado de completitud de la tarea.
  const PopupMenuButtonWidget({
    Key? key,
    required this.onSuccess,
    required this.onDelete,
    required this.isComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      // Constructor de los elementos del menú emergente.
      itemBuilder: (BuildContext context) {
        return [
          // Elemento del menú para finalizar tarea, solo habilitado si la tarea está incompleta.
          PopupMenuItem<String>(
            enabled: isComplete == 0,
            onTap: onSuccess, // Llama a la función onSuccess al hacer tap.
            value: 'Finalizar tarea',
            // Contenido del elemento del menú.
            child: const Row(
              children: [
                Icon(Icons.check_circle_outline),
                SizedBox(width: 10),
                Text('Finalizar tarea'),
              ],
            ),
          ),
          // Elemento del menú para eliminar tarea.
          PopupMenuItem<String>(
            onTap: onDelete, // Llama a la función onDelete al hacer tap.
            value: 'Eliminar tarea',
            // Contenido del elemento del menú.
            child: const Row(
              children: [
                Icon(Icons.delete_outline),
                SizedBox(width: 10),
                Text('Eliminar tarea'),
              ],
            ),
          ),
        ];
      },
    );
  }
}
