import 'package:flutter/foundation.dart';

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
