import 'dart:async';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:seek/core/models/error_model.dart';
import 'package:seek/features/task/data/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

// Helper para la gestión de la base de datos de tareas.
class TaskDatabaseHelper {
  static const _databaseName = "tasks.db";
  static const _databaseVersion = 1;

  Database? _database;

  // Obtiene la instancia de la base de datos.
  Future<Either<ErrorModel, Database>> get database async {
    try {
      if (_database != null) return Right(_database!);

      // Obtiene la ruta de la base de datos.
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = File('${documentsDirectory.path}/$_databaseName').path;

      // Abre la base de datos.
      _database = await openDatabase(path, version: _databaseVersion,
          onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, isComplete INTEGER)');
      });
      return Right(_database!);
    } catch (e) {
      return Left(
          ErrorModel(title: "Database Error", description: e.toString()));
    }
  }

  // Inserta una tarea en la base de datos.
  Future<Either<ErrorModel, void>> insertTask(TaskModel task) async {
    final dbOrError = await database;
    return dbOrError.fold(
      (error) => Left(error),
      (db) async {
        try {
          await db.insert('Tasks', task.toMap());
          return const Right(null);
        } catch (e) {
          return Left(
              ErrorModel(title: "Insert Error", description: e.toString()));
        }
      },
    );
  }

  // Obtiene todas las tareas de la base de datos.
  Future<Either<ErrorModel, List<TaskModel>>> getAllTasks() async {
    final dbOrError = await database;
    return dbOrError.fold(
      (error) => Left(error),
      (db) async {
        try {
          final tasks = await db.query('Tasks');
          final taskList =
              tasks.map((taskMap) => TaskModel.fromMap(taskMap)).toList();
          return Right(taskList);
        } catch (e) {
          return Left(
              ErrorModel(title: "Query Error", description: e.toString()));
        }
      },
    );
  }

  // Actualiza una tarea en la base de datos.
  Future<Either<ErrorModel, void>> updateTask(TaskModel task) async {
    final dbOrError = await database;
    return dbOrError.fold(
      (error) => Left(error),
      (db) async {
        try {
          await db.update('Tasks', task.toMap(),
              where: 'id = ?', whereArgs: [task.id]);
          return const Right(null);
        } catch (e) {
          return Left(
              ErrorModel(title: "Update Error", description: e.toString()));
        }
      },
    );
  }

  // Elimina una tarea de la base de datos.
  Future<Either<ErrorModel, void>> deleteTask(TaskModel task) async {
    final dbOrError = await database;
    return dbOrError.fold(
      (error) => Left(error),
      (db) async {
        try {
          await db.delete('Tasks', where: 'id = ?', whereArgs: [task.id]);
          return const Right(null);
        } catch (e) {
          return Left(
              ErrorModel(title: "Delete Error", description: e.toString()));
        }
      },
    );
  }
}
