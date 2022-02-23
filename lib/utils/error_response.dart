import 'dart:convert';

import 'package:scs_latakia_app/utils/api_response.dart';

class ErrorResponse extends ApiResponse {
  ErrorResponse({
    required this.statusCode,
    required this.message,
    this.error,
  });

  int statusCode;
  dynamic error;
  String message;

  factory ErrorResponse.fromRawJson(String str) =>
      ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
        statusCode: json["statusCode"],
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "error": error,
        "message": message,
      };
}
