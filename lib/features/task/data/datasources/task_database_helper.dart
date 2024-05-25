import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

// Helper para la gestión de la base de datos de tareas.
class TaskDatabaseHelper {
  static const _databaseName = "tasks.db";
  static const _databaseVersion = 1;

  Database? _database;

  // Obtiene la instancia de la base de datos.
  Future<Database> get database async {
    if (_database != null) return _database!;

    // Obtiene la ruta de la base de datos.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = File('${documentsDirectory.path}/$_databaseName').path;

    // Abre la base de datos.
    _database = await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isComplete INTEGER)');
    });
    return _database!;
  }

  // Inserta una tarea en la base de datos.
  Future<void> insertTask(TaskModel task) async {
    try {
      final db = await database;
      await db.insert('Tasks', task.toMap());
    } catch (e) {
      print(e);
    }
  }

  // Obtiene todas las tareas de la base de datos.
  Future<List<TaskModel>> getAllTasks() async {
    final db = await database;
    final tasks = await db.query('Tasks');
    return tasks.map((taskMap) => TaskModel.fromMap(taskMap)).toList();
  }

  // Actualiza una tarea en la base de datos.
  Future<void> updateTask(TaskModel task) async {
    final db = await database;
    await db
        .update('Tasks', task.toMap(), where: 'id = ?', whereArgs: [task.id]);
  }

  // Elimina una tarea de la base de datos.
  Future<void> deleteTask(TaskModel task) async {
    final db = await database;
    await db.delete('Tasks', where: 'id = ?', whereArgs: [task.id]);
  }
}
