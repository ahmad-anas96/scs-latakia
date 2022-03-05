import 'dart:convert';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    this.google,
    this.linkedin,
    required this.role,
    required this.name,
    this.tags,
    this.bio,
    this.imagePath,
    this.birthDate,
    required this.mobile,
    this.isActive,
  });

  String id;
  String email;
  String? google;
  String? linkedin;
  String role;
  String name;
  String? tags;
  String? bio;
  String? imagePath;
  String? birthDate;
  String mobile;
  bool? isActive;

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        google: json["google"],
        linkedin: json["linkedin"],
        role: json["role"],
        name: json["name"],
        tags: json["tags"],
        bio: json["bio"],
        imagePath: json["imagePath"],
        birthDate: json["birthDate"],
        mobile: json["mobile"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "google": google,
        "linkedin": linkedin,
        "role": role,
        "name": name,
        "tags": tags,
        "bio": bio,
        "imagePath": imagePath,
        "birthDate": birthDate,
        "mobile": mobile,
        "isActive": isActive,
      };
}
