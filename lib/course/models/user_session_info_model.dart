import 'dart:convert';

class UserSessionInfoModel {
  UserSessionInfoModel({
    required this.id,
    this.cocheNote,
    required this.sessionId,
    required this.userId,
  });

  String id;
  String? cocheNote;
  String sessionId;
  String userId;

  factory UserSessionInfoModel.fromRawJson(String str) =>
      UserSessionInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSessionInfoModel.fromJson(Map<String, dynamic> json) =>
      UserSessionInfoModel(
        id: json["id"],
        cocheNote: json["cocheNote"],
        sessionId: json["SessionId"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cocheNote": cocheNote,
        "SessionId": sessionId,
        "UserId": userId,
      };
}
