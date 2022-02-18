import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_fitz/data/todo_repository.dart';
import 'package:todo_app_fitz/services/firestore_services.dart';
import 'data/firebase_todo_repository.dart';
import 'home/app.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  final provider = FirebaseTodoRepository(FirestoreService());
  provider.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoRepository>.value(value: provider),
      ],
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
const _inputDecorationTheme = InputDecorationTheme(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  labelStyle: TextStyle(color: AppColor.borderColor),
  disabledBorder: _inputBorder,
  enabledBorder: _inputBorder,
  focusedBorder: _inputBorder,
  focusColor: AppColor.borderColor,
  border: _inputBorder,
  focusedErrorBorder: _errorBorder,
  errorBorder: _errorBorder,
);
const _inputBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: AppColor.borderColor),
);
const _errorBorder = UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.red),
);
