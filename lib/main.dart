import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/models.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              ListTile(
                title: Text(mockTodos[0].title),
                trailing: Checkbox(
                  value: mockTodos[0].isCompleted,
                  onChanged: (newValue) {
                    // TODO:
                  },
                ),
                subtitle: Text(mockTodos[0].date.toString()),
              ),
            ],
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
