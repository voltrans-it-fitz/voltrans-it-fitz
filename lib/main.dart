import 'package:flutter/material.dart';

import 'app.dart';

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
      home: const App(),
    );
  }
}
