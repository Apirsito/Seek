import 'package:flutter/material.dart';
import 'package:seek/core/utils/app_colors.dart';
import 'package:seek/core/utils/utlis.dart';
import 'package:seek/features/task/data/models/task_model.dart';

// Widget para mostrar una alerta con campos de entrada.
class AlertWidget extends StatelessWidget {
  const AlertWidget({Key? key, required this.continueAction}) : super(key: key);

  // Función de callback que se llama cuando se hace clic en "Aceptar".
  final void Function(TaskModel) continueAction;

  @override
  Widget build(BuildContext context) {
    // Variable para almacenar el nombre ingresado.
    String name = '';
    // Variable para almacenar el correo electrónico ingresado.
    String description = '';

    return AlertDialog(
      // Título de la alerta.
      title: const Text('Alerta'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'Nombre'),
            onChanged: (String nameInput) {
              // Actualiza el valor del nombre.
              name = nameInput;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Descripcion'),
            onChanged: (String descriptionInput) {
              // Actualiza el valor del correo electrónico.
              description = descriptionInput;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Cierra la alerta cuando se hace clic en "Cancelar".
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if (validateForm(name: name, description: description)) {
              continueAction(
                TaskModel(
                  // Genera un ID aleatorio para la tarea.
                  id: Utils.uuidToInt(),
                  // Usa el nombre ingresado como título de la tarea.
                  title: name,
                  // Usa el correo electrónico ingresado como descripción de la tarea.
                  description: description,
                  // Establece el estado de la tarea como incompleta.
                  isComplete: 0,
                ),
              );
              // Cierra la alerta cuando se hace clic en "Aceptar".
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: AppColors.primaryColor,
                  content: Text('Por favor, complete todos los campos'),
                ),
              );
            }
          },
          // Texto del botón de aceptar.
          child: const Text('Aceptar'),
        ),
      ],
    );
  }

//Metodo para validar el formulario
  bool validateForm({required String name, required String description}) {
    // Elimina los espacios en blanco de los extremos de las cadenas y luego verifica si están vacías
    if (name.trim().isNotEmpty && description.trim().isNotEmpty) {
      return true; // Si ambos campos no están vacíos después de eliminar los espacios en blanco, retorna verdadero
    } else {
      return false; // De lo contrario, retorna falso
    }
  }
}
