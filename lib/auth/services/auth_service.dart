import 'dart:developer';

import 'package:scs_latakia_app/auth/models/login_request_model.dart';
import 'package:scs_latakia_app/auth/models/login_response_model.dart';
import 'package:scs_latakia_app/auth/models/register_request_model.dart';
import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<LoginResponseModel?> login(LoginRequestModel model) async {
    try {
      var response = await http.post(
        Uri.parse("$ROOT_API/user/login"),
        body: model.toJson(),
      );
      if (response.statusCode == 200) {
        return LoginResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<LoginResponseModel?> register(
      RegisterRequestModel model) async {
    try {
      var response =
          await http.post(Uri.parse("$ROOT_API/user"), body: model.toJson());
      log(response.body);
      if (response.statusCode == 201) {
        return LoginResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> changePassword(
      String id, String oldPassword, String newPassword) async {
    try {
      var response = await http.put(Uri.parse("$ROOT_API/user/password"),
          body: {
            "id": id,
            "oldPassword": oldPassword,
            "newPassword": newPassword
          },
          headers: getHeaders());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> editProfile(UserModel user) async {
    try {
      var response = await http.put(Uri.parse("$ROOT_API/user"),
          body: {
            "id": user.id,
            "email": user.email,
            "name": user.name,
            "bio": user.bio,
            "mobile": user.mobile,
          },
          headers: getHeaders());
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e, s) {
      log("$e $s");
      return false;
    }
  }
}
