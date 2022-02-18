import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../models/models.dart';

abstract class TodoRepository with ChangeNotifier {
  UnmodifiableListView get todos;
  UnmodifiableListView get completedTodos;
  int get todoCount;
  int get completedTodoCount;
  Future<void> insert(Todo todo);
  Future<void> delete(Todo todo);
  Future<void> update(Todo todo);
  Future<void> toggle(Todo todo);
  void showCompletedTodos();
}
