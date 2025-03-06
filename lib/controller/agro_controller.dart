import 'dart:developer';
import 'dart:io';
import 'package:agronom_ai/data/model/error_ai_model.dart';
import 'package:agronom_ai/data/model/result_ai_model.dart';
import 'package:agronom_ai/data/repository/agro_services_repo.dart';
import 'package:flutter/foundation.dart';

class AgroController extends ChangeNotifier {
  final AgroServicesRepo agroServicesRepo;

  bool isloading = false;
  bool isAllowed = false;
  String message = '';
  String imageUrl = '';
  File? file;
  ErrorAiModel? errorAiModel;
  ResultAiModel? resultAiModel;

  AgroController({required this.agroServicesRepo});

  // 🟢 LOGIN
  Future<void> login(
      {required String password, required String phoneNumber}) async {
    isloading = true;
    notifyListeners();

    final result = await agroServicesRepo.login(
        phoneNumber: phoneNumber, password: password);

    result.fold(
      (failure) {
        message = failure.toString();
      },
      (success) {
        isAllowed = success;
        if (!isAllowed) {
          message = "Login yoki Password xato";
        }
      },
    );

    isloading = false;
    notifyListeners();
  }

  // 🟢 REGISTER
  Future<void> register(
      {required String password, required String phoneNumber}) async {
    isloading = true;
    notifyListeners();

    final result = await agroServicesRepo.register(
        phoneNumber: phoneNumber, password: password);

    result.fold(
      (failure) {
        message = failure.toString();
      },
      (success) {
        isAllowed = success;
        if (!isAllowed) {
          message = "Login yoki Password xato";
        }
      },
    );

    isloading = false;
    notifyListeners();
  }

  // 🟢 PICK PICTURE
  Future<void> pickPicture() async {
    file = await agroServicesRepo.pickImage();
    imageUrl = ''; // Reset the previous image URL
    notifyListeners();
  }

  // 🟢 UPLOAD PICTURE
  Future<void> uploadPicture() async {
    if (file == null) {
      log("No file selected");
      return;
    }

    final result = await agroServicesRepo.postImage(file: file!);
    if (result != null) {
      imageUrl = result.data.url;
      notifyListeners();
    } else {
      log("Failed to upload image");
    }
  }

  // 🟢 GET AI MODEL RESULT
  Future<void> resultAIModel() async {
    isloading = true;
    notifyListeners();

    final result = await agroServicesRepo.insectPredict(imageUrl: imageUrl);

    result!.fold(
      (failure) {
        errorAiModel = failure;
        resultAiModel = null;
      },
      (success) {
        resultAiModel = success;
        errorAiModel = null;
      },
    );

    isloading = false;
    notifyListeners();
  }
}
