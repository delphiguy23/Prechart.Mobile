import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:prechart_mobile/endpoints/endpoints.dart';
import 'package:prechart_mobile/models/userModel.dart';

class UserTokens with ChangeNotifier{

  UserModel _user = UserModel();

  UserModel get user
  {
    checkTokens();
    return _user;
  }

  bool isExpired() => (_user.bearerToken ==  null || _user.bearerToken!.isEmpty) ? false : Jwt.isExpired(_user.bearerToken ?? '');

  void setUser({
    required String bearerToken,
    required String refreshToken,
    required String apiKey,
    required String userName,
  }){
    _user.apiKey = apiKey;
    _user.bearerToken = bearerToken;
    _user.refreshToken = refreshToken;
    _user.userName = userName;
    notifyListeners();
  }

  void clearUser(){
    _user.apiKey = "";
    _user.bearerToken = "";
    _user.refreshToken = "";
    _user.apiKey = "";
    _user.userName = "";
    notifyListeners();
  }

  void checkTokens() async {
    if (Jwt.isExpired(_user?.bearerToken ?? '')) {
      var result = await Endpoints().getRefreshTokens(_user);
      _user.bearerToken = result?.bearerToken;
      _user.refreshToken = result?.refreshToken;
      _user.apiKey = result?.apiKey;
      _user.userName = result?.userName;
    }
  }
}