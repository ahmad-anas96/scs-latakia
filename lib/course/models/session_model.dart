import 'dart:convert';

class SessionModel {
    SessionModel({
        required this.id,
        this.summary,
        required this.dateTime,
        required this.courseId,
    });

    String id;
    String? summary;
    DateTime dateTime;
    String courseId;

    factory SessionModel.fromRawJson(String str) => SessionModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
        id: json["id"],
        summary: json["summary"],
        dateTime: DateTime.parse(json["dateTime"]),
        courseId: json["CourseId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "summary": summary,
        "dateTime": dateTime.toIso8601String(),
        "CourseId": courseId,
    };
}
