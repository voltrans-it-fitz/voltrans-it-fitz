class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime date;

  Todo({
    this.isCompleted = false,
    required this.id,
    required this.title,
    required this.date,
  });
}

final mockTodos = [
  Todo(id: 'Todo Id', title: 'Learn Provider', date: DateTime.now()),
  Todo(id: 'Todo Id', title: 'Writing Todo App', date: DateTime(1, 10, 2022)),
  Todo(id: 'Todo Id', title: 'Testing', date: DateTime(7, 2, 2022)),
];
