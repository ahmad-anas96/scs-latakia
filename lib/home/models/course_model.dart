import 'dart:convert';

class CourseModel {
  CourseModel({
    required this.id,
    required this.title,
    this.subTitle,
    required this.cost,
    required this.description,
    required this.tags,
    required this.imagePath,
    required this.coverPath,
    required this.sessionsNum,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  String id;
  String title;
  String? subTitle;
  int cost;
  String description;
  String tags;
  String imagePath;
  String coverPath;
  int sessionsNum;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory CourseModel.fromRawJson(String str) =>
      CourseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json["id"],
        title: json["title"],
        subTitle: json["subTitle"],
        cost: json["cost"],
        description: json["description"],
        tags: json["tags"],
        imagePath: json["imagePath"],
        coverPath: json["coverPath"],
        sessionsNum: json["sessionsNum"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "subTitle": subTitle,
        "cost": cost,
        "description": description,
        "tags": tags,
        "imagePath": imagePath,
        "coverPath": coverPath,
        "sessionsNum": sessionsNum,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
