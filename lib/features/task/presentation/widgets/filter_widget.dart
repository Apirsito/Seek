import 'package:flutter/material.dart';

// Widget para el filtro de tareas.
class FilterWidget extends StatelessWidget {
  // Función para manejar el cambio en el filtro.
  final void Function(int?) onchange;
  // Valor actual del filtro.
  final int value;

  const FilterWidget({
    Key? key,
    required this.onchange,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // Dropdown para seleccionar el filtro.
      child: DropdownButton<int>(
        // Valor actual del filtro seleccionado.
        value: value,
        // Icono del dropdown.
        icon: const Icon(Icons.filter_alt),
        items: const [
          // Opción "Todos".
          DropdownMenuItem(value: -1, child: Text("Todos")),
          // Opción "Pendiente".
          DropdownMenuItem(value: 0, child: Text("Pendiente")),
          // Opción "Completo".
          DropdownMenuItem(value: 1, child: Text("Completo")),
        ],
        // Función para manejar el cambio en el filtro.
        onChanged: onchange,
      ),
    );
  }
}
