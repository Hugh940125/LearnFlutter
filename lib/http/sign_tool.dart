import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class SignTool{
  static String getSign(Map<String,dynamic> params,String appSecret){
    StringBuffer buffer = StringBuffer();
    if (params != null){
      var mapKeys = params.keys.toList();
      mapKeys.sort();
      for(var key in mapKeys){
        dynamic value = params[key];
        if (value is String || value is bool){
          if(!(''==value) && !('sign'==key)){
            if (buffer.length>0){
              buffer.write("&" + key + "=" + value);
            }else{
              buffer.write(key + "=" + value);
            }
          }
        }else if (value is num){
          if (buffer.length>0){
            buffer.write("&" + key + "=" + value.toString());
          }else{
            buffer.write(key + "=" + value.toString());
          }
        }
      }
    }
    if (!(''==appSecret)){
      buffer.write(appSecret);
    }
    return generateMd5(buffer.toString());
  }

  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}