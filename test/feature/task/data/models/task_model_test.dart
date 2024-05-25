import 'package:flutter_test/flutter_test.dart';
import 'package:seek/features/task/data/models/task_model.dart';

void main() {
  group('TaskModel', () {
    test('Inicializar los valores correctos.', () {
      final tarea = TaskModel(
        id: 1,
        title: 'Tarea de Prueba',
        description: 'Descripción de Prueba',
        isComplete: 0,
      );

      expect(tarea.id, 1);
      expect(tarea.title, 'Tarea de Prueba');
      expect(tarea.description, 'Descripción de Prueba');
      expect(tarea.isComplete, 0);
    });

    test('Convertir a mapa correctamente', () {
      final mapa = {
        'id': 1,
        'title': 'Tarea de Prueba',
        'description': 'Descripción de Prueba',
        'isComplete': 0,
      };

      final tarea = TaskModel.fromMap(mapa);
      final mapaConvertido = tarea.toMap();

      expect(mapaConvertido, mapa);
    });

    test('Convertir a string correctamente', () {
      final tarea = TaskModel(
        id: 1,
        title: 'Tarea de Prueba',
        description: 'Descripción de Prueba',
        isComplete: 0,
      );

      expect(
        tarea.toString(),
        'Task(id: 1, title: Tarea de Prueba, description: Descripción de Prueba, isComplete: 0)',
      );
    });
  });
}
