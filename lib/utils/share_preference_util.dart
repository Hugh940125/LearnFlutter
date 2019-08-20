import 'package:shared_preferences/shared_preferences.dart';

class SharePreferenceUtil {

  static SharePreferenceUtil _instance;

  factory SharePreferenceUtil() =>_sharedInstance();

  static SharePreferenceUtil _sharedInstance() {
    if (_instance == null) {
      _instance = SharePreferenceUtil._();
    }
    return _instance;
  }

  SharePreferenceUtil._();

  Future<String> getString(String key) async {
    var str;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    str = prefs.getString(key);
    if (str == null){
      str = '';
    }
    return str;
  }

  saveString(String key,String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<bool> getBool(String key) async {
    var b;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    b = prefs.getBool(key);
    return b;
  }

  saveBool(String key,bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }
}
