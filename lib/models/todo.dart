import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Todo {
  final String _id;
  final String title;
  bool isCompleted;
  final DateTime date;

  String get formattedDate => DateFormat('dd MMMM yyyy').format(date);

  Todo({
    String? id,
    this.isCompleted = false,
    required this.title,
    required this.date,
  }) : _id = id == null ? const Uuid().v1() : '';

  @override
  String toString() {
    return 'Todo(id: $_id, title: $title, isCompleted: $isCompleted, date: $date)';
  }
}

final mockTodos = [
  Todo(id: 'Todo Id', title: 'Learn Provider', date: DateTime.now()),
  Todo(id: 'Todo Id', title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
  Todo(id: 'Todo Id', title: 'Testing', date: DateTime(2022, 7, 2)),
  Todo(id: 'Todo Id', title: 'Learn Provider', date: DateTime.now()),
  Todo(id: 'Todo Id', title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
  Todo(id: 'Todo Id', title: 'Testing', date: DateTime(2022, 7, 2)),
  Todo(id: 'Todo Id', title: 'Learn Provider', date: DateTime.now()),
  Todo(id: 'Todo Id', title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
  Todo(id: 'Todo Id', title: 'Testing', date: DateTime(2022, 7, 2)),
  Todo(id: 'Todo Id', title: 'Learn Provider', date: DateTime.now()),
  Todo(id: 'Todo Id', title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
  Todo(id: 'Todo Id', title: 'Testing', date: DateTime(2022, 7, 2)),
];
