import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_app_fitz/data/todo_repository.dart';
import 'package:todo_app_fitz/services/firestore_services.dart';
import '../models/todo.dart';

class FirebaseTodoRepository with ChangeNotifier implements TodoRepository {
  final FirestoreService firestore;
  FirebaseTodoRepository(this.firestore);

  late StreamSubscription todoStreamSubscription;
  List<Todo> _todos = [];
  bool isLoading = true;

  @override
  UnmodifiableListView get todos => UnmodifiableListView(_todos);
  @override
  get completedTodoCount => _todos.where((e) => e.isCompleted).toList().length;
  @override
  get todoCount => _todos.length;

  final todoCollection = FirebaseFirestore.instance.collection('_todos');

  @override
  Future<void> insert(Todo todo) => firestore.insert(todo);
  @override
  Future<void> delete(Todo todo) => firestore.delete(todo);
  @override
  Future<void> toggle(Todo todo) => firestore.toggle(todo);
  @override
  Future<void> update(Todo todo) => firestore.update(todo);

  void create() {
    todoStreamSubscription = firestore.todosStream().listen(eventHandler);
  }

  @override
  void dispose() {
    todoStreamSubscription.cancel();
    super.dispose();
  }

  void eventHandler(QuerySnapshot<Map<String, dynamic>> snapshots) {
    final docChanges = snapshots.docChanges;
    isLoading = true;
    
    for (var change in docChanges) {
      final todo = Todo.fromDocument(change.doc);
      switch (change.type) {
        case DocumentChangeType.added:
          _todos.insert(0, Todo.fromDocument(change.doc));
          break;
        case DocumentChangeType.modified:
          var i = _todos.indexWhere((e) => e.id == todo.id);
          _todos[i] = todo;
          break;
        case DocumentChangeType.removed:
          _todos.remove(Todo.fromDocument(change.doc));
          break;
        default:
      }
    }
    isLoading = false;
    notifyListeners();
  }

  @override
  UnmodifiableListView get completedTodos =>
      UnmodifiableListView(_todos.where((todo) => todo.isCompleted));

  @override
  void showCompletedTodos() {
    _todos = _todos.where((element) => element.isCompleted).toList();
    notifyListeners();
  }
}
