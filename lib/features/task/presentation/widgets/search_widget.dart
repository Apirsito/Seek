import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final void Function(String)? onchange;
  final TextEditingController controller;
  const SearchWidget(
      {required this.onchange, super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(255, 255, 255, 255),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Color de la sombra
              spreadRadius: 1, // Radio de difuminado
              blurRadius: 1, // Radio de borrosidad
              offset: const Offset(0, 0), // Desplazamiento de la sombra
            )
          ]),
      margin: const EdgeInsets.only(left: 15, top: 20, bottom: 10, right: 15),
      child: TextFormField(
        controller: controller,
        onChanged: onchange,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          labelStyle: TextStyle(backgroundColor: Colors.white),
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
