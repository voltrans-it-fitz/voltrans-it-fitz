import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'todo.dart';

class TodoManager extends ChangeNotifier {
  final List<Todo> _todos;

  get todos => UnmodifiableListView(_todos);

  get completedTodoCount => _todos.where((e) => e.isCompleted).toList().length;

  get todosLength => _todos.length;

  TodoManager({required List<Todo> todos}) : _todos = todos;

  toggleTodo(int index) {
    _todos[index].isCompleted = !_todos[index].isCompleted;
    notifyListeners();
  }

  deleteTodo(int index) {
    _todos.removeAt(index);
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
