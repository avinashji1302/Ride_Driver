import 'dart:io';

import 'package:app/config/networks/api_reposne.dart';
import 'package:app/screens/auth/register/model/request_regoster_model.dart';
import 'package:app/screens/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider extends ChangeNotifier {
  final repository = AuthRepository();
  final ImagePicker _picker = ImagePicker();

  final emailController = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final dobController = TextEditingController();
  final mobileController = TextEditingController();
  final secMobileController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();
  final bloodController = TextEditingController();
   String? vehicleTypeController = "Select Vehicle Type";
     final ownerMobileController = TextEditingController();

  XFile? selectedImage;
  String profilePic = "";
  bool isLoading = false;

  Future<void> pickImage(ImageSource source) async {
    final XFile? file = await _picker.pickImage(source: source);
    if (file != null) {
      selectedImage = file;
      await uploadProfileImage();
      debugPrint("choosen image : $selectedImage");
      notifyListeners();
    }
  }

  Future<ApiResponse<void>> uploadProfileImage() async {
    isLoading = true;
    notifyListeners();

    try {
      final imageFile = File(selectedImage!.path);

      final response = await repository.uploadProfileImage(imageFile);

      debugPrint("result : $response");

      if (response != null) {
        profilePic = response.data!;
      }

      debugPrint("Data is : ${response.data}");

      isLoading = false;
      notifyListeners();
      return ApiResponse(success: true, message: "response.message");
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

  //register model

  Future<ApiResponse> registerHere() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.registerDriver(
        RequestDriverRegisterModel(
          mobile: mobileController.text,
          countryCode: "91",
          email: emailController.text,
          firstName: firstName.text,
          lastName: lastName.text,
          dob: dobController.text,
          primaryMobile: mobileController.text,
          secondaryMobile: secMobileController.text,
          city: cityController.text,
          address: addressController.text,
          state: stateController.text,
          bloodGroup: bloodController.text,
          languages: ["Hindi"],
          profile: profilePic,
          vehicleType: vehicleTypeController??"",
          vehicleNumber: "bhbjhj",
          vehicleModel: "kmkk",
          rcNumber: "klmlm",
          ownerDetails: OwnerDetails(mobile:ownerMobileController.text, name: 'ownler'),
          driverIsOwner: true,
          vehicleAge: 5,
          isSafetyTested: true,
          color: "red",
          seatingCapacity: 4,
        ),
      );

      debugPrint("result : $response");

      if (response != null) {}

      debugPrint("Data is : ${response.data}");

      isLoading = false;
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
}
