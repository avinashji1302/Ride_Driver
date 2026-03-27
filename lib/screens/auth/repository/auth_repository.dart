import 'dart:convert';
import 'dart:io';

import 'package:app/config/networks/api_endpoints.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/networks/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/auth/login/model/send_otp_response.dart';
import 'package:app/screens/auth/login/model/varify_otp_response.dart';
import 'package:app/screens/auth/register/model/register_model.dart';
import 'package:app/screens/auth/register/model/request_regoster_model.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  //-------------------------------login------------------------
  Future<ApiResponse<SendOtpResponse>> login(
    String mobile,
    String countryCode,
  ) async {
    debugPrint("data is : ${mobile} $countryCode");

    final responsne = await HttpClient.post(
      ApiEndpoints.login,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
      },
      body: {"mobile": mobile, "countryCode": countryCode},
    );

    debugPrint("login result : ${responsne.body}");

    final json = jsonDecode(responsne.body);

    return ApiResponse<SendOtpResponse>.fromJson(
      json,
      (data) => SendOtpResponse.fromJson(data),
    );
  }

  //-------------------------------Varfiy OTP------------------------
  Future<ApiResponse<VarifyOtpResponse>> varifyOTP(
    String mobileOtpId,
    String otp,
    String deviceId,
    String deviceType,
    String deviceToken,
  ) async {

        debugPrint("input $otp $mobileOtpId $deviceId $deviceType ");
    final responsne = await HttpClient.post(
      ApiEndpoints.varifyOTP,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
      },
      body: {
        "mobileOtpId": mobileOtpId,
        "otp": otp,
        "deviceId": deviceId,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
      },
    );




    debugPrint("varify result : ${responsne.body}");
    final json = jsonDecode(responsne.body);

    return ApiResponse<VarifyOtpResponse>.fromJson(
      json,
      (data) => VarifyOtpResponse.fromJson(data),
    );
  }

  //------------------------------- getting image Url of profiel--------------------------------

  Future<ApiResponse<String>> uploadProfileImage(File imageFile) async {
    final token = await AuthStorage().getAccessToken();

    debugPrint("token ......: $token");

    final response = await HttpClient.multipart(
      ApiEndpoints.uploadImage,
      file: imageFile,
      fieldName: "image",
      headers: {"Accept": "application/json"},
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

  // ------------------------------------register driver-----------------------------------

  Future<ApiResponse<RegisterModel>> registerDriver(
    RequestDriverRegisterModel request,
  ) async {
    final responsne = await HttpClient.post(
      ApiEndpoints.register,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
      },
      body: request.toJson(),
    );

    debugPrint("varify result : ${responsne.body}");
    final json = jsonDecode(responsne.body);

    return ApiResponse<RegisterModel>.fromJson(json, (data) => (RegisterModel.fromJson(data)));
  }



//    //------------------------------- getting image Url of profiel--------------------------------

//   Future<ApiResponse<String>> uploadDocsImage(File imageFile) async {
   

  

//     final response = await HttpClient.multipart(
//       ApiEndpoints.uploadImage,
//       file: imageFile,
//       fieldName: "image",
//       headers: { "Accept": "application/json"},
//     );

//     final json = jsonDecode(response.body);

//     debugPrint(
//       "image response response : ${response.body}. ${json['results']['imageUrl']}",
//     );

//     return ApiResponse<String>.fromJson(
//       json,
//      (data) => (data as Map<String, dynamic>)['imageUrl'] as String,
//     );
//   }

//   //----------------------------------------------update profile---------------------------------

//  Future<ApiResponse<void>> uploadDriverDocuments({
//   String? aadharFront,
//   String? aadharBack,
//   String? licenseFront,
//   String? licenseBack,
//   String? rcFront,
//   String? rcBack,
//   String? pan,
//   String? insurance,
// }) async {
  

//   final response = await HttpClient.post(
//     ApiEndpoints.uploadDocs,
//     headers: {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     },
//     body: {
//       "aadharFront": aadharFront,
//       "aadharBack": aadharBack,
//       "dlFront": licenseFront,
//       "dlBack": licenseBack,
//       "rcFront": rcFront,
//       "rcBack": rcBack,
//       "panFront": pan,
    
//     },
//   );






// // rcFront
// // rcBack

//   debugPrint("UPLOAD DOCS RESPONSE: ${response.body}");

//   final json = jsonDecode(response.body);

//   return ApiResponse<void>.fromJson(json, (_) {});
// }
}
