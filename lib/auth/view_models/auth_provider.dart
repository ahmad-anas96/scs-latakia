import 'package:flutter/material.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';

class AuthProvider extends ChangeNotifier {  
  static LoginData? _loginData;
  static LoginData? get loginData => _loginData;

  setLoginData(LoginData? value) {
    _loginData = value;
    notifyListeners();
  }

  bool isLoggedIn() => _loginData != null;
}
