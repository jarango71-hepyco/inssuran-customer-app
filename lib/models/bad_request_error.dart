import 'dart:convert';

BadRequestError badRequestErrorFromJson(String str) => BadRequestError.fromJson(json.decode(str));

String badRequestErrorToJson(BadRequestError data) => json.encode(data.toJson());

class BadRequestError {
  BadRequestError({
    required this.value,
    required this.errors,
    required this.isSuccess,
  });

  final String value;
  final List<String> errors;
  final bool isSuccess;

  factory BadRequestError.fromJson(Map<String, dynamic> json) => BadRequestError(
    value: json["value"].toString(),
    errors: List<String>.from(json["errors"].map((x) => x)),
    isSuccess: json["isSuccess"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "errors": List<dynamic>.from(errors.map((x) => x)),
    "isSuccess": isSuccess,
  };
}
