import 'package:flutter/material.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  static LoginData? _loginData;
  static LoginData? get loginData => _loginData;

  setLoginData(LoginData? value) {
    _loginData = value;
    _saveLogin();
    notifyListeners();
  }

  bool isLoggedIn() => _loginData != null;

  Future<void> _saveLogin() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString("login", _loginData?.toRawJson() ?? '');
  }
}
