import 'package:intl/intl.dart';

class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime date;

  String get formattedDate => DateFormat('dd MMMM yyyy').format(date);

  const Todo({
    this.isCompleted = false,
    required this.id,
    required this.title,
    required this.date,
  });

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, isCompleted: $isCompleted, date: $date)';
  }
}

final mockTodos = [
  Todo(id: 'Todo Id', title: 'Learn Provider', date: DateTime.now()),
  Todo(id: 'Todo Id', title: 'Writing Todo App', date: DateTime(2022, 1, 10)),
  Todo(id: 'Todo Id', title: 'Testing', date: DateTime(2022, 7, 2)),
];
