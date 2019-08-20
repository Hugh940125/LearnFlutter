import 'dart:collection';
import 'package:flutter/material.dart';

class NavigationUtil {
  static void navigationTo(BuildContext context, Widget widget) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => widget, maintainState: false));
  }
}
