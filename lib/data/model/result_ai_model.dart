import 'package:json_annotation/json_annotation.dart';

part 'result_ai_model.g.dart';

@JsonSerializable()
class ResultAiModel {
  @JsonKey(name: "data")
  final Data data;

  ResultAiModel({
    required this.data,
  });

  factory ResultAiModel.fromJson(Map<String, dynamic> json) =>
      _$ResultAiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultAiModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "image")
  final String image;
  @JsonKey(name: "type")
  final Type type;
  @JsonKey(name: "confidence")
  final int confidence;
  @JsonKey(name: "ai_chats")
  final List<AiChat> aiChats;
  @JsonKey(name: "created_at")
  final String createdAt;

  Data({
    required this.id,
    required this.image,
    required this.type,
    required this.confidence,
    required this.aiChats,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class AiChat {
  @JsonKey(name: "content")
  final String content;
  @JsonKey(name: "isAiResponse")
  final String isAiResponse;
  @JsonKey(name: "created_at")
  final String createdAt;

  AiChat({
    required this.content,
    required this.isAiResponse,
    required this.createdAt,
  });

  factory AiChat.fromJson(Map<String, dynamic> json) => _$AiChatFromJson(json);

  Map<String, dynamic> toJson() => _$AiChatToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(name: "id")
  final String typeId;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "name_uz")
  final String nameUz;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "images")
  final List<String> images;

  Type({
    required this.id,
    required this.typeId,
    required this.name,
    required this.nameUz,
    required this.description,
    required this.images,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
