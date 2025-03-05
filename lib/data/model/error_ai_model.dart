import 'package:json_annotation/json_annotation.dart';

part 'error_ai_model.g.dart';

@JsonSerializable()
class ErrorAiModel {
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "error")
  final String error;
  @JsonKey(name: "statusCode")
  final int statusCode;

  ErrorAiModel({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory ErrorAiModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorAiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorAiModelToJson(this);
}
