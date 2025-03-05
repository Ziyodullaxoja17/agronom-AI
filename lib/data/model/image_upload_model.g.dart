// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageUploadModel _$ImageUploadModelFromJson(Map<String, dynamic> json) =>
    ImageUploadModel(
      data: Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImageUploadModelToJson(ImageUploadModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      url: json['url'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'url': instance.url,
      'name': instance.name,
    };
