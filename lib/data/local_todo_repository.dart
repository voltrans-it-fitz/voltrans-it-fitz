import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/models.dart';
import 'todo_repository.dart';

class LocalTodoRepository with ChangeNotifier implements TodoRepository {
  late Database db;
  Future open() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          'create table todo(id text primary key, title text, date string, isCompleted string)',
        );
      },
      version: 1,
    );
    // debugPrint('database opened sucessfully');
    db = await database;
    // debugPrint(db.toString());
  }

  @override
  UnmodifiableListView get todos {
    getAllTodo();
    notifyListeners();
    return UnmodifiableListView([]);
  }

  Future<List<Todo>> getAllTodo() async {
    final List<Map<String, dynamic>> todos = await db.query('todo');
    return todos.map((e) => Todo.fromMap(e)).toList();
  }

  @override
  Future<void> insert(Todo todo) async {
    await db.insert(
      'todo',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  // TODO: implement completedTodoCount
  int get completedTodoCount => throw UnimplementedError();

  @override
  Future<void> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  // TODO: implement todoCount
  int get todoCount => throw UnimplementedError();

  @override
  Future<void> update(Todo todo) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> toggle(Todo todo) {
    // TODO: implement toggle
    throw UnimplementedError();
  }

  @override
  // TODO: implement completedTodos
  UnmodifiableListView get completedTodos => throw UnimplementedError();

  @override
  void showCompletedTodos() {
    // TODO: implement showCompletedTodos
  }
}
