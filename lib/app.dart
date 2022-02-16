import 'package:flutter/material.dart';
import 'package:todo_app_fitz/todo.dart';
import 'package:todo_app_fitz/todo_tile.dart';

import 'add_todo.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  // Simulate get the todos from service
  List<Todo> todos = [...mockTodos];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fitz Todo App')),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: todos.length,
          itemBuilder: (context, index) => TodoTile(
            todos[index],
            onSwipe: (_) => setState(() => todos.removeAt(index)),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Todo todo = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTodoPage()),
          );
          setState(() {
            todos.add(todo);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
