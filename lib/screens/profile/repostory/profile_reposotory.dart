import 'dart:convert';
import 'dart:io';

import 'package:app/config/networks/api_endpoints.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/networks/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/profile/model/user_profile.dart';
import 'package:flutter/material.dart';

class ProfileReposotory {
  Future<ApiResponse<void>> driveLogout() async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token : $token");

    final response = await HttpClient.post(
      ApiEndpoints.logout,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    debugPrint("raw response : ${response.body}");

    final json = jsonDecode(response.body);
    return ApiResponse<void>.fromJson(json, (_) {});
  }

  //------------------------------- getting image Url of profiel--------------------------------

  Future<ApiResponse<String>> uploadDocsImage(File imageFile) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.multipart(
      ApiEndpoints.uploadImage,
      file: imageFile,
      fieldName: "image",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    final json = jsonDecode(response.body);

    debugPrint(
      "image response response : ${response.body}. ${json['results']['imageUrl']}",
    );

    return ApiResponse<String>.fromJson(
      json,
      (data) => (data as Map<String, dynamic>)['imageUrl'] as String,
    );
  }

  //----------------------------------------------Document upload...---------------------------------

  Future<ApiResponse<void>> uploadDriverDocuments({
    File? aadharFront,
    File? aadharBack,
    File? licenseFront,
    File? licenseBack,
    File? rcFront,
    File? rcBack,
    File? pan,
  }) async {
    final token = await AuthStorage().getAccessToken();

    /// RAW MAP (WITH NULL)
    final rawFiles = {
      "aadharFront": aadharFront,
      "aadharBack": aadharBack,
      "dFront": licenseFront,
      "dBack": licenseBack,
      "rcFront": rcFront,
      "rcBack": rcBack,
      "panFront": pan,
    };

    /// REMOVE NULL FILES 🔥
    final Map<String, File> files = {};
    rawFiles.forEach((key, value) {
      if (value != null) {
        files[key] = value;
      }
    });

    /// DEBUG KEYS
    debugPrint("🚀 FINAL FILE KEYS SENT: ${files.keys}");

    final response = await HttpClient.docmultipartMultiple(
      ApiEndpoints.uploadDocs,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      files: {
        "aadharFront": aadharFront,
        "aadharBack": aadharBack,
        "dlFront": licenseFront, // ✅ FIX
        "dlBack": licenseBack, // ✅ FIX
        "rcFront": rcFront,
        "rcBack": rcBack,
        "panFront": pan,
      },
    );

    final json = jsonDecode(response.body);

    return ApiResponse<void>.fromJson(json, (_) {});
  }

  //----------------------------------------------Profile upload---------------------------------
  Future<ApiResponse<UserProfileModel>> getUserProfile() async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token : $token");
    final resposne = await HttpClient.get(
      ApiEndpoints.getProfile,
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    final json = jsonDecode(resposne.body);

    debugPrint("json respons e: $json");

    return ApiResponse<UserProfileModel>.fromJson(
      json,
      (data) => UserProfileModel.fromJson(data),
    );
  }

  // v1/driver/update-profile

  //----------------------------------------------Update Profile ---------------------------------

  Future<ApiResponse<UserProfileModel>> updateUserProfile(Map<String, dynamic> body) async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token : $token ");
     debugPrint("body ... $body");
    final resposne = await HttpClient.post(
      ApiEndpoints.updateProfle,

      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },

      body: body,
    );
    final json = jsonDecode(resposne.body);

    debugPrint("json respons e: $json");

    return ApiResponse<UserProfileModel>.fromJson(
      json,
      (data) => UserProfileModel.fromJson(data),
    );
  }
}
