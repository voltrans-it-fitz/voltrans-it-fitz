import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';

class FirestoreService {
  final todoCollection = FirebaseFirestore.instance.collection('todos');

  Stream<QuerySnapshot<Map<String, dynamic>>> todosStream() =>
      todoCollection.orderBy('date', descending: true).snapshots();

  Future<void> insert(Todo todo) async =>
      await todoCollection.doc(todo.id).set(todo.toDocument());

  Future<void> delete(Todo todo) async =>
      await todoCollection.doc(todo.id).delete();

  Future<void> toggle(Todo todo) async =>
      todoCollection.doc(todo.id).update({'isCompleted': !todo.isCompleted});

  Future<void> update(Todo todo) async =>
      todoCollection.doc(todo.id).update(todo.toDocument());
}
