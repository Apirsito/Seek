import 'package:flutter/material.dart';

// Widget que muestra un campo de búsqueda.
class SearchWidget extends StatelessWidget {
  // Callback que se llama cuando cambia el texto de búsqueda.
  final void Function(String)? onchange;

  // Controlador del campo de texto para el campo de búsqueda.
  final TextEditingController controller;

  // Constructor que requiere el callback de cambio y el controlador del campo de texto.
  const SearchWidget({
    required this.onchange,
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 0),
          )
        ],
      ),
      margin: const EdgeInsets.only(left: 15, top: 20, bottom: 10, right: 15),
      child: TextFormField(
        controller: controller,
        onChanged: onchange,
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          contentPadding: EdgeInsets.all(0),
          labelStyle: TextStyle(backgroundColor: Colors.transparent),
          labelText: 'Buscar...',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            gapPadding: 4.0,
          ),
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
