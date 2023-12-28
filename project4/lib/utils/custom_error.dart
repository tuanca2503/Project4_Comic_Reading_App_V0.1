class CustomError {
  int status;
  String message;

  CustomError.fromJson(dynamic json)
      : status = json['status'],
        message = json['message'];
}