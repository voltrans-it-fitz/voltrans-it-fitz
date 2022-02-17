import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'todo.dart';

class TodoManager with ChangeNotifier {
  final List<Todo> _todos;

  UnmodifiableListView get todos => UnmodifiableListView(_todos);

  get completedTodoCount => _todos.where((e) => e.isCompleted).toList().length;

  get todosLength => _todos.length;

  TodoManager({required List<Todo> todos}) : _todos = todos;

  toggleTodo({required String id}) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  updateTodo(String id, Todo todo) {
    var index = _todos.indexWhere((element) => element.id == id);
    _todos[index] = todo;
    notifyListeners();
  }

  addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }
}
