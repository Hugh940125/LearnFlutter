import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_app/http/sign_tool.dart';
import 'package:flutter_app/http/sub_url.dart';
import 'package:flutter_app/utils/share_preference_util.dart';

import 'config.dart';

class HttpUtil {
  Dio dio;

  HttpUtil._() {
    dio = new Dio();
    dio.options.baseUrl = Config.baseUrl;
    dio.options.connectTimeout = 15000;
    dio.options.receiveTimeout = 30000;
    dio.options.contentType =
        ContentType.parse("application/json;charset=UTF-8");
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      String token = await SharePreferenceUtil().getString('token');
      dio.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      };
      return options;
    }, onResponse: (Response response) {
      return response;
    }, onError: (DioError error) {
      return error;
    }));
    LogInterceptor(responseBody: false);
  }

  //get请求
  void get(String url, Function callBack, Function onRefreshToken,
      {Map<String, dynamic> params, Function errorCallBack}) async {
    _request(url, callBack, onRefreshToken,
        method: 'GET', params: params, errorCallBack: errorCallBack);
  }

  //加密post请求
  void signPost(String url, Function callBack, Function onRefreshToken,
      {Map<String, dynamic> params, Function errorCallBack}) async {
    _request(Config.baseUrl + url, callBack, onRefreshToken,
        method: 'POST',
        params: params,
        errorCallBack: errorCallBack,
        sign: true);
  }

  //post请求
  void post(String url, Function callBack, Function onRefreshToken,
      {Map<String, dynamic> params, Function errorCallBack}) async {
    _request(Config.baseUrl + url, callBack, onRefreshToken,
        method: 'POST',
        params: params,
        errorCallBack: errorCallBack,
        sign: false);
  }

  void _request(String url, Function callBack, Function onRefreshToken,
      {String method,
      Map<String, dynamic> params,
      Function errorCallBack,
      bool sign}) async {
    int statusCode;
    try {
      Response response;
      if (method == 'GET') {
        if (params != null && params.isNotEmpty) {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await dio.get(url);
      } else if (method == 'POST') {
        if (params != null && params.isNotEmpty) {
          if (sign) {
            params['appKey'] = Config.appKey;
            params['timestamp'] =
                (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString();
            params['sign'] = SignTool.getSign(params, Config.appSecret);
          }
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
      statusCode = response.statusCode;
      String res2Json = json.encode(response.data);
      Map<String, dynamic> map = json.decode(res2Json);
      if (statusCode == 200) {
        if (map['code'] == 1) {
          if (callBack != null) {
            callBack(map["data"]);
          }
        } else if (map['code'] == 10006) {
          _refreshToken(onRefreshToken);
        }
      } else {
        _handError(errorCallBack, map['message']);
      }
    } catch (exception) {
      _handError(errorCallBack, exception.toString());
    }
  }

  void _handError(Function errorCallBack, String errorMsg) {
    if (errorCallBack != null) {
      errorCallBack(errorMsg);
    }
  }

  static HttpUtil _instance = HttpUtil._();

  factory HttpUtil() => _getInstance();

  static HttpUtil _getInstance() {
    return _instance;
  }

  Future _refreshToken(Function onRefreshToken) async {
    String refreshToken = await SharePreferenceUtil().getString('refreshToken');
    HttpUtil().signPost(SubUrl.refreshToken, (data) {
      
    }, (){

    },params: {'refreshToken': refreshToken}, errorCallBack: (errorMsg) {});
  }
}
