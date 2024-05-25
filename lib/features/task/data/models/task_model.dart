// Modelo de datos para una tarea.
class TaskModel {
  // Identificador único de la tarea.
  int id;

  // Título de la tarea.
  String title;

  // Descripción de la tarea.
  String description;

  // Indica si la tarea está completada o no.
  int isComplete;

  // Constructor de la clase TaskModel.
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isComplete,
  });

  // Método de fábrica para crear una instancia de TaskModel a partir de un mapa.
  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      isComplete: map['isComplete'] as int,
    );
  }

  // Método para convertir TaskModel a un mapa.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isComplete': isComplete,
    };
  }

  // Método para obtener una representación en cadena de TaskModel.
  @override
  String toString() {
    return 'Task(id: $id, title: $title, description: $description, isComplete: $isComplete)';
  }
}
