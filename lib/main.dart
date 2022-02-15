import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/models.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<IndexChangeNotifier>(
          create: (context) => IndexChangeNotifier(0),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              ListTile(
                title: Text(mockTodo.title),
                trailing: Checkbox(
                  value: mockTodo.isCompleted,
                  onChanged: (newValue) {
                    // TODO:
                  },
                ),
                subtitle: Text(mockTodo.date.toString()),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<IndexChangeNotifier>().increment();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

final mockTodo = Todo(
  id: 'Todo Id',
  title: 'Learn Provider',
  date: DateTime.now(),
);
