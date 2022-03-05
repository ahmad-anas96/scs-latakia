import 'dart:convert';

class RegisterRequestModel {
  RegisterRequestModel({
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
  });

  String name;
  String email;
  String mobile;
  String password;

  factory RegisterRequestModel.fromRawJson(String str) =>
      RegisterRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      RegisterRequestModel(
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "mobile": mobile,
        "password": password,
      };
}
