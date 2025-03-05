import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:agronom_ai/data/model/error_ai_model.dart';
import 'package:agronom_ai/data/model/image_upload_model.dart';
import 'package:agronom_ai/data/model/result_ai_model.dart';
import 'package:http/http.dart' as http;
import 'package:agronom_ai/data/common/network_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgroServicesRepo {
  final dio = Dio();

  // login services here
  Future<Either<dynamic, bool>> login(
      {required String phoneNumber, required String password}) async {
    try {
      final body = {
        "phone_number": phoneNumber,
        "auth_method": "phone-number",
        "password": password
      };
      final response = await dio.post(NetworkConstants.loginUrl,
          options: Options(
            headers: {
              "accept": "application/json",
              "Content-Type": "application/json"
            },
          ),
          data: body);

      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        final result = response.data;
        final token = result["data"]["access_token"];

        await prefs.setString("token", token);
        return right(true);
      }
      return right(false);
    } catch (e) {
      log(e.toString());
      return left("Tizimga kirishda muommoga duch kelindi");
    }
  }

  // register service here
  Future<Either<dynamic, bool>> register(
      {required String phoneNumber, required String password}) async {
    try {
      final body = {
        "phone_number": phoneNumber,
        "auth_method": "phone-number",
        "password": password
      };
      final response = await dio.post(NetworkConstants.registerUrl,
          options: Options(
            headers: {
              "accept": "application/json",
              "Content-Type": "application/json"
            },
          ),
          data: body);

      if (response.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();
        final result = response.data;
        final token = result["data"]["access_token"];

        await prefs.setString("token", token);
        return right(true);
      }
      return right(false);
    } catch (e) {
      log(e.toString());
      return left("Tizimga kirishda muommoga duch kelindi");
    }
  }

// taking image here => only return image here
  Future<File?> pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage =
          await imagePicker.pickImage(source: ImageSource.camera);
      return pickedImage != null ? File(pickedImage.path) : null;
    } catch (e) {
      log("Error picking image: $e");
      return null;
    }
  }

  Future<ImageUploadModel?> postImage({required File file}) async {
    try {
      String fileName = file.path.split('/').last;
      String fileExtens = fileName.split(".").last.toLowerCase();

      if (!["jpg", "jpeg", "png"].contains(fileExtens)) {
        throw Exception("Invalid file type: $fileExtens");
      }

      final uploadUrl = Uri.parse(NetworkConstants.imageUpload);
      final request = http.MultipartRequest("POST", uploadUrl);

      // Add file to request
      request.files.add(
        await http.MultipartFile.fromPath(
          "file",
          file.path,
          filename: fileName,
          contentType:
              MediaType("image", fileExtens == "jpg" ? "jpeg" : fileExtens),
        ),
      );

      // Add token to header
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("token");
      if (token == null) {
        throw Exception("User is not authenticated. Token is missing.");
      }
      request.headers['Authorization'] = 'Bearer $token';

      // Sending request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        log("Image uploaded successfully: ${response.body}");
        return ImageUploadModel.fromJson(
            jsonDecode(response.body)); // Return server response
      } else {
        log("Failed to upload image: ${response.body}");
      }
    } catch (e) {
      log("Error uploading image: $e");
    }
    return null;
  }

// predict by upoading image here
  Future<Either<ErrorAiModel, ResultAiModel>> insectPredict(
      {required String imageUrl}) async {
    // to get token here
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    try {
      // creating body part
      final body = {"image_path": imageUrl};
      final response = await dio.post(NetworkConstants.predictUrl,
          options: Options(
            headers: {
              "accept": "application/json",
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
            },
          ),
          data: body);

      if (response.statusCode == 201) {
        return right(ResultAiModel.fromJson(response.data));
      }
      return left(ErrorAiModel.fromJson(response.data));
    } catch (e) {
      log(e.toString());
      throw Exception(e.toString());
    }
  }
}
