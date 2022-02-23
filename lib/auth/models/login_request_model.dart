import 'dart:convert';

class LoginRequestModel {
  LoginRequestModel({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  factory LoginRequestModel.fromRawJson(String str) =>
      LoginRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      LoginRequestModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
