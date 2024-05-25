import 'package:flutter/material.dart';
import 'package:seek/core/utils/app_colors.dart';

// Widget que muestra un diálogo de alerta con opciones "Sí" y "No".
class AlertWidget extends StatelessWidget {
  // Callback que se llama cuando se selecciona la opción "Sí".
  final VoidCallback action;

  // Título del diálogo de alerta.
  final String title;

  // Descripción del diálogo de alerta.
  final String description;

  // Constructor que requiere la función de acción, el título y la descripción del diálogo.
  const AlertWidget({
    Key? key,
    required this.action,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Text(
        description,
        style: const TextStyle(fontSize: 15),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pop(); // Cierra el diálogo sin realizar ninguna acción.
          },
          child: const Text(
            'No',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors
                  .primaryColor, // Color de texto personalizado desde AppColors.
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            action(); // Llama a la función de acción.
            Navigator.of(context)
                .pop(); // Cierra el diálogo después de realizar la acción.
          },
          child: const Text(
            'Sí',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors
                  .primaryColor, // Color de texto personalizado desde AppColors.
            ),
          ),
        ),
      ],
    );
  }
}
