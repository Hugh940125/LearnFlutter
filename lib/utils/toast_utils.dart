import 'package:flutter/material.dart';

class ToastUtils{

  static void showToast(BuildContext context,String msg) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }
}