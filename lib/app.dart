import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return Container(
      color: ThemeData().primaryColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
            toolbarHeight: MediaQuery.of(context).size.height * 0.15,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 0,
                child: ListTile(
                  title: Text(
                    'My Todos',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                  ),
                  subtitle: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text('3 out of 5'),
                  ),
                ),
              ),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: todos.length,
            itemBuilder: (context, index) => TodoTile(
              todos[index],
              onSwipe: (_) => setState(() => todos.removeAt(index)),
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
        ),
      ),
    );
  }
}
