// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_ai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultAiModel _$ResultAiModelFromJson(Map<String, dynamic> json) =>
    ResultAiModel(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultAiModelToJson(ResultAiModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      id: json['_id'] as String,
      image: json['image'] as String,
      type: Type.fromJson(json['type'] as Map<String, dynamic>),
      confidence: (json['confidence'] as num).toInt(),
      aiChats: (json['ai_chats'] as List<dynamic>)
          .map((e) => AiChat.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '_id': instance.id,
      'image': instance.image,
      'type': instance.type,
      'confidence': instance.confidence,
      'ai_chats': instance.aiChats,
      'created_at': instance.createdAt,
    };

AiChat _$AiChatFromJson(Map<String, dynamic> json) => AiChat(
      content: json['content'] as String,
      isAiResponse: json['isAiResponse'] as String,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$AiChatToJson(AiChat instance) => <String, dynamic>{
      'content': instance.content,
      'isAiResponse': instance.isAiResponse,
      'created_at': instance.createdAt,
    };

Type _$TypeFromJson(Map<String, dynamic> json) => Type(
      id: json['_id'] as String,
      typeId: json['id'] as String,
      name: json['name'] as String,
      nameUz: json['name_uz'] as String,
      description: json['description'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TypeToJson(Type instance) => <String, dynamic>{
      '_id': instance.id,
      'id': instance.typeId,
      'name': instance.name,
      'name_uz': instance.nameUz,
      'description': instance.description,
      'images': instance.images,
    };
