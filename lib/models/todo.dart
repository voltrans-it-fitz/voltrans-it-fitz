import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Todo {
  final String _id;
  final String title;
  bool isCompleted;
  final DateTime date;

  String get id => _id;
  String get formattedDate => DateFormat('dd MMMM yyyy').format(date);

  Todo({
    String? id,
    this.isCompleted = false,
    required this.title,
    required this.date,
  }) : _id = id ?? const Uuid().v1();

  @override
  String toString() {
    return 'Todo(id: $_id, title: $title, isCompleted: $isCompleted, date: $date)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      isCompleted: map['isCompleted'] == 0 ? false : true,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  factory Todo.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) => Todo(
        id: doc.id,
        title: doc['title'] ?? '',
        isCompleted: doc['isCompleted'],
        date: DateTime.fromMillisecondsSinceEpoch(doc['date']),
      );

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'date': date.millisecondsSinceEpoch,
    };
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other._id == _id &&
        other.title == title &&
        other.isCompleted == isCompleted &&
        other.date == date;
  }

  @override
  int get hashCode {
    return _id.hashCode ^ title.hashCode ^ isCompleted.hashCode ^ date.hashCode;
  }

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? date,
  }) {
    return Todo(
      id: id ?? _id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
    );
  }
}

final mockTodos = [
  Todo(title: 'Learn Provider', date: DateTime.now()),
  Todo(title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
  Todo(title: 'Testing', date: DateTime(2022, 7, 2)),
  Todo(title: 'Learn Provider', date: DateTime.now()),
  Todo(title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
];
