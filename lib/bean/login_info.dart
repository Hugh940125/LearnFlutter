import 'package:json_annotation/json_annotation.dart';
part 'login_info.g.dart';

//flutter packages pub run build_runner build
@JsonSerializable()
class LoginInfo{
  String accessToken;
  int expiresIn;
  String refreshToken;
  String tokenType;
  String memberName;
  String memberAddress;
  int memberAge;
  String memberBirthday;
  int memberId;
  String memberIdcard;
  String memberMobile;
  int memberSex;
  String memberNick;
  String memberPicture;
  int itemId;
  String itemName;
  String identityId;
  String authCode;
  int day;
  String ownerName;
  String ownerPhone;
  int tenantId;

  LoginInfo(this.accessToken, this.expiresIn, this.refreshToken, this.tokenType,
      this.memberName, this.memberAddress, this.memberAge, this.memberBirthday,
      this.memberId, this.memberIdcard, this.memberMobile, this.memberSex,
      this.memberNick, this.memberPicture, this.itemId, this.itemName,
      this.identityId, this.authCode, this.day, this.ownerName, this.ownerPhone,
      this.tenantId);

  factory LoginInfo.fromJson(Map<String, dynamic> json) => _$LoginInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginInfoToJson(this);
}