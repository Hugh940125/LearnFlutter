import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/home_page.dart';
import 'package:flutter_app/list_page.dart';

import 'bean/login_info.dart';
import 'http/http_util.dart';
import 'http/sub_url.dart';
import 'utils/share_preference_util.dart';

class MyLoginPage extends StatefulWidget {
  final String title;

  MyLoginPage({Key key, this.title}) : super(key: key);

  @override
  _MyLoginPageState createState() => new _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  TextEditingController accountController;
  TextEditingController pwdController;
  Color buttonColor = const Color(0xFFEAEFF5);

  @override
  void initState() {
    super.initState();
    accountController = TextEditingController();
    pwdController = TextEditingController();
    accountController.addListener(() {
      setButtonState();
    });
    pwdController.addListener(() {
      setButtonState();
    });
    //监听页面绘制完成
//    WidgetsBinding widgetsBinding = WidgetsBinding.instance;
//    widgetsBinding.addPostFrameCallback((callback) {
//      widgetsBinding.addPostFrameCallback((callback) {
//        //显示状态栏和虚拟键
//        //    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
//        SystemChrome.setEnabledSystemUIOverlays(
//            [SystemUiOverlay.top, SystemUiOverlay.bottom]);
//      });
//    });
  }

  void setButtonState() {
    if (accountController.text.length > 0 && pwdController.text.length > 0) {
      setState(() {
        buttonColor = const Color(0xFF4690EF);
      });
    } else {
      buttonColor = const Color(0xFFEAEFF5);
    }
  }

  void _toast(BuildContext context, String msg) {
    var bar = new SnackBar(
      content: new Text(msg),
      //action: SnackBarAction(label: 'OK',onPressed: ,),
    );
    Scaffold.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Builder(builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16, 92, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "登录",
                  style: TextStyle(
                    fontSize: 28,
                    color: const Color(0xFF1F2633),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: TextField(
                  controller: accountController,
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '请输入手机号',
                    hintStyle:
                        TextStyle(fontSize: 16, color: const Color(0xFFA4A7AC)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 40, 16, 0),
                child: TextField(
                  controller: pwdController,
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '请输入密码',
                    hintStyle:
                        TextStyle(fontSize: 16, color: const Color(0xFFA4A7AC)),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _gotoHome(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadiusDirectional.all(Radius.circular(8)),
                    color: buttonColor,
                  ),
                  margin: EdgeInsets.fromLTRB(16, 48, 16, 0),
                  alignment: Alignment.center,
                  constraints: BoxConstraints.expand(height: 52),
                  child: Text(
                    '登录',
                    style: TextStyle(
                      fontSize: 18,
                      backgroundColor: Colors.transparent,
                      color: const Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  _gotoHome(BuildContext context) {
    if (accountController.text.trim().length == 0) {
      _toast(context, "账号不能为空");
      return;
    }
    if (pwdController.text.trim().length == 0) {
      _toast(context, "密码不能为空");
      return;
    }
//    Navigator.pushAndRemoveUntil(
//        context,
//        MaterialPageRoute(
//            builder: (context) => MyHomePage(
//                  title: "主页",
//                )),
//        (route) => route == null);
    _requestLogin(accountController.text.trim(),pwdController.text.trim());
  }

  _requestLogin(String account,String pwd){
    HttpUtil().signPost(SubUrl.login, (data){
      LoginInfo loginInfo = LoginInfo.fromJson(data);
      _saveLoginInfo(loginInfo);
    }, (){
      _requestLogin(account,pwd);
    },params: {'mobile':account,'password':pwd,'platform':'2','extPlatform':''},errorCallBack: (errorMsg){

    });
  }

  _toListPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new MyListPage()),
    );
  }

  void _saveLoginInfo(LoginInfo loginInfo) {
    SharePreferenceUtil().saveBool('isLogin', true);
    SharePreferenceUtil().saveString('token', loginInfo.accessToken);
    SharePreferenceUtil().saveString('refreshToken', loginInfo.refreshToken);
  }
}
