import 'package:app/config/networks/api_reposne.dart';
import 'package:app/screens/home/model/Socket/ride_accept_socket_model.dart';
import 'package:app/screens/home/model/arrived_model.dart';
import 'package:app/screens/home/model/ride_accepted_model.dart';
import 'package:app/screens/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

enum HomeFlow { homepage, newRide, rideAccepted, arrived, jouneystarted , reachedDestination }

class HomeProvider extends ChangeNotifier {
  final repository = HomeRepository();
  final otpController = TextEditingController();
  RideAcceptedModel? rideDetails;
  ArrivedModel? reachedAtLocation ;

  int tapBottemIndex = 0;
  bool isDriverAvailable = false;
  String incomingRideId = "";

  HomeFlow _flow = HomeFlow.homepage;
  HomeFlow get flow => _flow;

  bool isLoading = false;
  String otp='';

  void changeTab(int index) {
    if (index == tapBottemIndex) return;
    tapBottemIndex = index;
    notifyListeners();
  }

  void isDriverOnline() {
    isDriverAvailable = true;
    notifyListeners();
  }

  /// ✅ Called from socket
  Future<void> incomingRide(RideAcceptedSocketModel data) async {
    debugPrint("📥 Incoming Ride ID: ${data.id} $data");

    incomingRideId = data.id;
    _flow = HomeFlow.newRide;

    notifyListeners();
  }

  /// Accept Ride API
  Future<ApiResponse<RideAcceptedModel>> rideAccepted() async {
    debugPrint("accespted tapped");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.rideAccepted(incomingRideId);

      if (response.data != null) {
        rideDetails = response.data;
        _flow = HomeFlow.rideAccepted;
        tapBottemIndex = 1;
      }

      debugPrint("accespted :$response");
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: true, message: response.message);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }

  /// Arrived Ride API
  Future<ApiResponse<ArrivedModel>> driverArrived() async {
    debugPrint("drivder arrived tapped");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.arrived(incomingRideId);


       debugPrint("driver arrived  ${response.message}  ${response.success}:$response");

      if (response.data != null) {
        _flow = HomeFlow.arrived;
      }

      debugPrint("accespted :$response");
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: true, message: response.message , data: response.data);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }

  /// Jouney Started
  Future<ApiResponse<ArrivedModel>> jouneystarted() async {
    debugPrint("Jouerney started1.......");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.journeyStart(incomingRideId , otpController.text);

      debugPrint("Jouerney started2....... ${response.message} ${response.success} ${response.data}");


      if (response.data != null) {
        _flow = HomeFlow.jouneystarted;
      }

      debugPrint("rJouerney started3 :${response.data} ${response.message} ${response.success}" );
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: true, message: response.message , data: response.data);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }



  /// Reached at the destination
  Future<ApiResponse<ArrivedModel>> reachedDestination() async {
    debugPrint("Reached at the destionation");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.reachedAtDestination(incomingRideId);

         debugPrint("Reached at the destionation ${response.message} ${response.success} ${response.data}");

      if (response.data != null) {
        reachedAtLocation=response.data;
       _flow=HomeFlow.reachedDestination;
      }

      debugPrint("reached destionation   :${response.data} ${response.message} ${response.success}" );
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: true, message: response.message , data: response.data);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }



  /// recieved  the payment
 Future<ApiResponse<ArrivedModel>> revievedPayemnt() async {
    debugPrint("payemnt recevied tapped");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.recievedPayment(incomingRideId);
  debugPrint("payemnt received ${response.message} ${response.success} ${response.data}");
      if (response.data != null) {
        tapBottemIndex=0;
      }

      debugPrint("received payemnt :${response.data} ${response.message} ${response.success}" );
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: true, message: response.message , data: response.data);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }
}
