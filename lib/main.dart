import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:seek/core/dependency_injection/dependency_injection.dart';
import 'package:seek/features/task/presentation/pages/task_page.dart';
import 'features/task/presentation/bloc/task_bloc.dart';

// Punto de entrada de la aplicación.
void main() {
  // Inicialización de los widgets de Flutter.
  WidgetsFlutterBinding.ensureInitialized();
  // Configuración de las dependencias de inyección de dependencias.
  configureDependencies();
  // Ejecución de la aplicación principal.
  runApp(const MyApp());
}

// Clase principal que representa la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Método de construcción de la interfaz de usuario.
  @override
  Widget build(BuildContext context) {
    // Proveedor de estado para el Bloc de tareas.
    return BlocProvider<TaskBloc>(
      // Creación del Bloc de tareas utilizando GetIt.
      create: (context) => GetIt.I<TaskBloc>(),
      // Definición de la interfaz de la aplicación.
      child: const MaterialApp(
        // Desactiva la bandera de depuración.
        debugShowCheckedModeBanner: false,
        // Título de la aplicación.
        title: 'Lista de Tareas',
        // Página inicial de la aplicación.
        home: TaskPage(),
      ),
    );
  }
}
