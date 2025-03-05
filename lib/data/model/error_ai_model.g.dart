// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_ai_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorAiModel _$ErrorAiModelFromJson(Map<String, dynamic> json) => ErrorAiModel(
      message: json['message'] as String,
      error: json['error'] as String,
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$ErrorAiModelToJson(ErrorAiModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'statusCode': instance.statusCode,
    };
