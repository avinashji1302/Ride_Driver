import 'dart:io';

import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/auth/register/model/request_regoster_model.dart';
import 'package:app/screens/auth/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider extends ChangeNotifier {
  final repository = AuthRepository();
    final AuthStorage _storage = AuthStorage();
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
  final vehicleModel = TextEditingController();
   String vehicleTypeController = "Select Vehicle Type";
     final ownerMobileController = TextEditingController();
     final secondaryMobileController = TextEditingController();
final vehicleNumberController = TextEditingController();
final rcNumberController = TextEditingController();
final vehicleColorController = TextEditingController();
final vehicleAgeController = TextEditingController();
final seatingCapacityController = TextEditingController();
final ownerNameController = TextEditingController();

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
        mobile: mobileController.text.trim(),
        countryCode: "91",
        email: emailController.text.trim(),
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        dob: dobController.text.trim(),
        primaryMobile: mobileController.text.trim(),
        secondaryMobile: secondaryMobileController.text.trim(),
        city: cityController.text.trim(),
        address: addressController.text.trim(),
        state: stateController.text.trim(),
        bloodGroup: bloodController.text.trim(),
        languages: ["Hindi", "English"],
        profile: profilePic,
        vehicleType: vehicleTypeController,
        vehicleNumber: vehicleNumberController.text.trim(),
        vehicleModel: vehicleModel.text.trim(),
        rcNumber: rcNumberController.text.trim(),
        ownerDetails: OwnerDetails(
          mobile: ownerMobileController.text.trim(),
          name: ownerNameController.text.trim(),
        ),
        driverIsOwner: true,
        vehicleAge: int.tryParse(vehicleAgeController.text) ?? 0,
        isSafetyTested: true,
        color: vehicleColorController.text.trim(),
        seatingCapacity:
            int.tryParse(seatingCapacityController.text) ?? 4,
      ),
      );

      debugPrint("result : $response");

      if (response != null) {
        
      }

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
