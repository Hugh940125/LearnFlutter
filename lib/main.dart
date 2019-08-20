import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body: SplashPage(),
      ),
      //home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }

  Future<bool> getLoginStates() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLogin = sharedPreferences.getBool("isLogin");
    return isLogin;
  }
}
