import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'todo_detail/todo_detail_page.dart';

import 'config/config.dart';
import 'models/models.dart';

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
        inputDecorationTheme: _inputDecorationTheme,
        appBarTheme: _appBarTheme,
        textTheme: const TextTheme(headline3: _h3Theme),
      ),
      home: const TodoDetailPage(),
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
const _inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  labelStyle: TextStyle(color: AppColor.borderColor),
  disabledBorder: _inputBorder,
  enabledBorder: _inputBorder,
  focusedBorder: _inputBorder,
  focusColor: AppColor.borderColor,
  border: _inputBorder,
  focusedErrorBorder: _inputBorder,
  errorBorder: _inputBorder,
);
const _inputBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: AppColor.borderColor),
);
