import 'package:app/config/networks/api_reposne.dart';
import 'package:app/screens/home/model/ride_accepted_model.dart';
import 'package:app/screens/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

enum HomeFlow { newRide }

class HomeProvider extends ChangeNotifier {
  final repository = HomeRepository();

  int tapBottemIndex = 0;

  HomeFlow _flow = HomeFlow.newRide;
  HomeFlow get flow => _flow;

  void changeTab(int index) {
    if (index == tapBottemIndex) {
      return;
    }

    debugPrint("index : $index");
    tapBottemIndex = index;

    notifyListeners();
  }

  void newRideComing() {
    _flow = HomeFlow.newRide;
    notifyListeners();
  }

  //------------------------ride accepted-----------------------

  bool isLoading = false;

  Future<ApiResponse<RideAcceptedModel>> rideAccepted() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.rideAccepted("rideId");
     if(response.data!=null){
      
     }

      return ApiResponse(success: true, message: "message");
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
