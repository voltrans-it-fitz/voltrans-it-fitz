import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'todo_repository.dart';

import '../models/todo.dart';

const todoTable = 'todo_table';
const String columnId = '_id';
const String columnTitle = 'title';
const String columnDate = 'date';
const String columnDone = 'done';

class MemoryTodoRepository with ChangeNotifier implements TodoRepository {
  final List<Todo> _todos;

  @override
  UnmodifiableListView get todos => UnmodifiableListView(_todos);

  UnmodifiableListView get completedTodo =>
      UnmodifiableListView(_todos.where((todo) => todo.isCompleted == false));

  @override
  get completedTodoCount => _todos.where((e) => e.isCompleted).toList().length;

  MemoryTodoRepository({required List<Todo> todos}) : _todos = todos;

  toggleTodo({required String id}) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  updateTodo(String id, Todo todo) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index] = todo;
    notifyListeners();
  }

  @override
  Future<void> delete(Todo todo) async {
    _todos.removeWhere((t) => t == todo);
    notifyListeners();
  }

  @override
  Future<void> insert(Todo todo) async {
    _todos.add(todo);
    notifyListeners();
  }

  @override
  int get todoCount => _todos.length;

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
