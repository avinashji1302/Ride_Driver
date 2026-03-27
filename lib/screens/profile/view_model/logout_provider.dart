import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/profile/model/user_profile.dart';
import 'package:app/screens/profile/repostory/profile_reposotory.dart';
import 'package:flutter/material.dart';

class LogoutProvider extends ChangeNotifier {
  bool isLoading = false;
  ProfileReposotory repository = ProfileReposotory();

   UserProfileModel? userPrifile;

  Future<ApiResponse> logout() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.driveLogout();
      isLoading = true;

      if (response.success) {
        AuthStorage().clear();
      }

      notifyListeners();
      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isLoading = false;
      debugPrint("error : ${e.toString()}");
      notifyListeners();

      return ApiResponse(
        success: false,
        message: "Something went wrong  ${e.toString()}",
      );
    }
  }

  //------------------------------------- gettting proifile------------------------------------------

  Future<ApiResponse<UserProfileModel>> getProfile() async {
  try {
    final response = await repository.getUserProfile();

    if (response.success) {

      /// ⭐⭐⭐ SAVE DATA (THIS WAS MISSING)
      userPrifile = response.data; // ⭐ ADDED

      debugPrint("respins e : $userPrifile");

      notifyListeners(); // ⭐ ADDED

      return ApiResponse(
        success: response.success,
        message: response.message,
        data: userPrifile, // ⭐ ADDED
      );
    }

    return ApiResponse(
      success: false,
      message: response.message ?? 'Failed to load profile',
    );
  } catch (e) {
    debugPrint("error : ${e.toString()}");

    return ApiResponse(
      success: false,
      message: "Something went wrong ${e.toString()}",
    );
  }
}

//update prfole.......
Future<ApiResponse> updateProfile(Map<String, dynamic> body) async {
  isLoading = true;
  notifyListeners();

  try {
    final res = await repository.updateUserProfile(body);

    isLoading = false;
    notifyListeners();

    return res;
  } catch (e) {
    isLoading = false;
    notifyListeners();

    return ApiResponse(success: false, message: e.toString());
  }
}
}
