class ResponseModel {
  final int statusCode;
  final dynamic data;
  final dynamic error;
  final String message;

  ResponseModel({
    required this.statusCode,
    this.data,
    this.error,
    required this.message,
  });
}
