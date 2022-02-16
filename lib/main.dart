import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/todo.dart';
import 'package:todo_app_fitz/todo_manager.dart';

import 'app.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoManager(todos: [...mockTodos]),
      child: const FitzTodoApp(),
    ),
  );
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
        appBarTheme: _appBarTheme,
        textTheme: const TextTheme(headline3: _h3Theme),
      ),
      home: const App(),
    );
  }
}

const _appBarTheme = AppBarTheme(

  actionsIconTheme: IconThemeData(color: Colors.black),
  elevation: 0,
  systemOverlayStyle: SystemUiOverlayStyle.light,
  backgroundColor: Colors.transparent,
);
const _h3Theme = TextStyle(
  fontWeight: FontWeight.w500,
  color: Colors.black,
);
