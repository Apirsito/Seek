// Entidad: Task
class Task {
  // Identificador único de la tarea.
  final int id;

  // Título de la tarea.
  final String title;

  // Descripción de la tarea.
  final String description;

  // Indica si la tarea está completada o no.
  final int isComplete;

  // Constructor de la clase Task.
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  });
}
