import 'package:json_annotation/json_annotation.dart';

part 'image_upload_model.g.dart';

@JsonSerializable()
class ImageUploadModel {
  @JsonKey(name: "data")
  final Data data;

  ImageUploadModel({
    required this.data,
  });

  factory ImageUploadModel.fromJson(Map<String, dynamic> json) =>
      _$ImageUploadModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageUploadModelToJson(this);
}

@JsonSerializable()
class Data {
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "name")
  final String name;

  Data({
    required this.url,
    required this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
