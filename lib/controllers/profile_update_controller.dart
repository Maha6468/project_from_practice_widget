import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import '../colors/app_colors.dart';
import '../common/app_loading.dart';
import '../common/global_widget.dart';
import '../data/network/dio_client.dart';
import '../data/repo/repo.dart';

class ProfileUpdateController extends GetxController {
  UpdateData args = Get.arguments as UpdateData;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  var fullName = "".obs;
  var email = "".obs;

  Rx<PlatformFile?> fileData = Rx<PlatformFile?>(null);

  @override
  void onInit() {
    if (args != null) {
      fullName(args.fullName);
      email(args.email);
    }
    super.onInit();
  }

  @override
  void onReady() {
    fullNameController.text = fullName.value;
    super.onReady();
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      // Handle Android permissions
      if (await Permission.storage.isGranted) return true;

      final status = await Permission.storage.request();
      if (status.isGranted) return true;

      // For Android 13+ (API 33+)
      if (await Permission.photos.request().isGranted) {
        return true;
      }

      if (status.isPermanentlyDenied) {
        openAppSettings();
      }
      return false;
    }
    else if (Platform.isIOS) {
      // iOS doesn't require runtime permission for document picker
      return true;
    }
    return true;
  }

  Future<void> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // or FileType.image, FileType.video, etc.
        allowMultiple: false,
        allowedExtensions: ['jpg', 'jpeg'],
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        print('File name: ${file.name}');
        print('File size: ${file.size}');
        print('File path: ${file.path}');
        fileData(file);
      }
    } catch (e) {
      print('Error while picking file: $e');
      errorSnack('Error while picking file: $e');
    }
  }

  Future<void> sendRequest() async {
    if (fullNameController.text.isEmpty) {
      Get.snackbar("Full Name", "Field should not be empty!", backgroundColor: AppColors.appSecondaryColor, colorText: Colors.white);
      return;
    }
    if (fileData.value == null) {
      Get.snackbar("Attachment", "Please attach a Document relevant with your name!", backgroundColor: AppColors.appSecondaryColor, colorText: Colors.white);
      return;
    }
    if (messageController.text.isEmpty) {
      Get.snackbar("Message", "Field should not be empty!", backgroundColor: AppColors.appSecondaryColor, colorText: Colors.white);
      return;
    }

    showLoading();

    try {
      var paths = await _getFileUri(fileData.value!.path!);
      print(paths);
      var formData = await http.MultipartFile.fromPath("file", paths, filename: path.basename(paths), contentType: MediaType("image", "jpeg"));


      var dataMap = {
        "username": fullNameController.text.trim(),
        "message": messageController.text.trim()
      };
      var result = await DioClient().getFromData( file: formData, dataMap: Map.of(dataMap));
      // var result = await UserRepo.getInstance().updateProfileRequest(
      //   data: formData,
      // );
      result.fold(
              (l) {
            print("update request left =============> $l");
            errorSnack(l['result']['ErrorMessage']);
          },
              (r) {
            print("update request right =============> $r");
            successSnack(r['result']['message'], onOK: () {
              Get.back();
            });
          });
      hideLoading();
    } catch (e) {
      print("update request catch =============> $e");
      hideLoading();
      errorSnack(e.toString());
    }
  }

  Future<String> _getFileUri(String filePath) async {
    if (Platform.isAndroid) {
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/${filePath.split('/').last}';
      await File(filePath).copy(tempPath);
      return tempPath;
    } else if (Platform.isIOS) {
      final dir = await getApplicationDocumentsDirectory();
      final newPath = '${dir.path}/${filePath.split('/').last}';
      await File(filePath).copy(newPath);
      return newPath;
    }
    return filePath;
  }
}

class UpdateData {
  final String fullName;
  final String email;

  UpdateData(this.fullName, this.email);
}