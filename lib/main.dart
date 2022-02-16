import 'package:flutter/material.dart';
import 'package:todo_app_fitz/todo.dart';

void main() {
  runApp(const FitzTodoApp());
}

class FitzTodoApp extends StatelessWidget {
  const FitzTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitz Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Fitz Todo App')),
        body: SafeArea(
          child: ListView(
            children: mockTodos.map((e) => TodoTile(e)).toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile(
    this.todo, {
    Key? key,
  }) : super(key: key);
  final Todo todo;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title),
      trailing: Checkbox(
        value: todo.isCompleted,
        onChanged: (newValue) {},
      ),
      subtitle: Text(todo.formattedDate),
    );
  }
}
