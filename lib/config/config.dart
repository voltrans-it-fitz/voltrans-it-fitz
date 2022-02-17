import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class SizeConfig {
  static const appBarRatio = 0.175;
  static const defaultPadding = 8.0;
  static const defaultRadius = 8.0;
}

abstract class AppColor {
  static const borderColor = Colors.black54;
}

extension MyDateFormat on DateTime {
  String ddMMYYYY() {
    return DateFormat('dd MMMM yyyy').format(this);
  }
}
