import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/login_page.dart';
import 'package:flutter_app/utils/SharePreferenceUtil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Image.asset(
          'images/pic_splash.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //隐藏虚拟键
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  _SplashPageState() {
    SharePreferenceUtil().saveBool('isLogin', false);
    Future<bool> isLogin;
    Future.delayed(
        Duration(seconds: 5),
        () => {
              isLogin = SharePreferenceUtil().getBool('isLogin'),
              isLogin.then((bool b) {
                if (b == null || !b) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyLoginPage(title: "登录")),
                      (route) => route == null);
                } else {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(
                                title: "主页",
                              )),
                      (route) => route == null);
                }
              }),
            });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }
}
