import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/socket/socket.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/core/device/device_details.dart';
import 'package:app/screens/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();
  final AuthStorage _storage = AuthStorage();

  final TextEditingController numberController = TextEditingController(
    text: "7777777777",
  );
  final TextEditingController otpController = TextEditingController(
    text: "1234",
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isloading = false;
  String mobileOtpId = "";

  //------------------------------------Login API----------------------------

  Future<ApiResponse> loginHandle() async {
    isloading = true;
    notifyListeners();

    try {
      final response = await repository.login(numberController.text, "+91");
      isloading = false;
      notifyListeners();

      debugPrint("response is : ${response.data}");

      if (response.success && response.data != null) {
        mobileOtpId = response.data!.mobileOtpId;

        debugPrint("mobile otpId: $mobileOtpId");

        return ApiResponse(
          success: response.success,
          message: response.message,
        );
      }

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isloading = false;
      notifyListeners();
      debugPrint("somethign : $e");
      return ApiResponse(success: false, message: "Something went wrong $e");
    }
  }

  //------------------------------------Login API----------------------------

  Future<ApiResponse> varifyOtpHandle(String mobileOtpIda) async {
    isloading = true;
    notifyListeners();

    try {
      final deviceId = await DeviceDetails.getDeviceId();
      final response = await repository.varifyOTP(
        mobileOtpIda,
        otpController.text,
        deviceId,
        "android",
        "",
      );

      debugPrint("passed data is : $mobileOtpId ${otpController.text} $deviceId ");
      isloading = false;
      notifyListeners();

      debugPrint("response is : ${response.data}");

      if (response.success && response.data != null) {
        await _storage.saveSession(
          accessToken: response.data!.token,
          refreshToken: response.data!.refreshToken,
        );

         final accessToken = await _storage.getAccessToken();
           SocketService().connect(accessToken!);

        return ApiResponse(
          success: response.success,
          message: response.message,
        );
      }

      return ApiResponse(success: response.success, message: response.message);
    } catch (e) {
      isloading = false;
      notifyListeners();
      debugPrint("somethign : $e");
      return ApiResponse(success: false, message: "Something went wrong $e");
    }
  }
}
