import 'dart:io';

import 'package:app/config/networks/api_reposne.dart';
import 'package:app/screens/auth/repository/auth_repository.dart';
import 'package:app/screens/profile/repostory/profile_reposotory.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'package:app/screens/profile/repostory/profile_reposotory.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'package:app/screens/profile/repostory/profile_reposotory.dart';

class UploadDocProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final ProfileReposotory repository = ProfileReposotory();

  XFile? aadharFront;
  XFile? aadharBack;
  XFile? licenseFront;
  XFile? licenseBack;
  XFile? rcFront;
  XFile? rcBack;
  XFile? pan;

  bool isLoading = false;

  /// PICK DOC
  Future<void> pickDoc(ImageSource source, String type) async {
    final file = await _picker.pickImage(source: source);

    if (file != null) {
      print("📸 Selected $type → ${file.path}");

      switch (type) {
        case "aadharFront":
          aadharFront = file;
          break;
        case "aadharBack":
          aadharBack = file;
          break;
        case "licenseFront":
          licenseFront = file;
          break;
        case "licenseBack":
          licenseBack = file;
          break;
        case "rcFront":
          rcFront = file;
          break;
        case "rcBack":
          rcBack = file;
          break;
        case "pan":
          pan = file;
          break;
      }

      notifyListeners();
    }
  }

  /// UPLOAD ALL
  Future<ApiResponse> uploadAllDocs() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await repository.uploadDriverDocuments(
        aadharFront:
            aadharFront != null ? File(aadharFront!.path) : null,
        aadharBack:
            aadharBack != null ? File(aadharBack!.path) : null,
        licenseFront:
            licenseFront != null ? File(licenseFront!.path) : null,
        licenseBack:
            licenseBack != null ? File(licenseBack!.path) : null,
        rcFront: rcFront != null ? File(rcFront!.path) : null,
        rcBack: rcBack != null ? File(rcBack!.path) : null,
        pan: pan != null ? File(pan!.path) : null,
      );

      print("✅ FINAL RESULT: ${result.message}");

      isLoading = false;
      notifyListeners();

      return result;
    } catch (e) {
      print("❌ ERROR: $e");

      isLoading = false;
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Upload failed: ${e.toString()}",
      );
    }
  }
}