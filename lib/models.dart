import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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

class IndexChangeNotifier with ChangeNotifier {
  int _index = 0;
  int get index => _index;
  IndexChangeNotifier(this._index);
  void increment() {
    _index++;

    notifyListeners();
  }
}

class StringModel {
  final String _title;

  StringModel(this._title);
  String get title => _title;
}
