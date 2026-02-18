import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/socket/socket.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/home/model/Socket/ride_accept_socket_model.dart';
import 'package:app/screens/home/model/arrived_model.dart';
import 'package:app/screens/home/model/availble_rides.dart';
import 'package:app/screens/home/model/ride_accepted_model.dart';
import 'package:app/screens/home/repository/home_repository.dart';
import 'package:flutter/material.dart';

enum HomeFlow {
  idle,
  homepage,
  newRide,
  rideAccepted,
  arrived,
  jouneystarted,
  reachedDestination,
}

class HomeProvider extends ChangeNotifier {
  final repository = HomeRepository();
  final otpController = TextEditingController();
  final AuthStorage _storage = AuthStorage();
  RideAcceptedModel? rideDetails;
  ArrivedModel? reachedAtLocation;

  int tapBottemIndex = 0;
  bool isDriverAvailable = false;
  String incomingRideId = "";

  HomeFlow _flow = HomeFlow.idle;
  HomeFlow get flow => _flow;

   List<AllRides>allAvailableRides=[]; 

  bool isLoading = false;
  String otp = '';

  void changeTab(int index) {
    if (index == tapBottemIndex) return;


    tapBottemIndex = index;
    if(index==0){
      allAvailableRides.clear();
      avilbleRdies();
    }
    notifyListeners();
  }

  void isDriverOnline() {
    isDriverAvailable = true;
    notifyListeners();
  }

  /// recieved  the payment
  Future<ApiResponse<ArrivedModel>> goOnline() async {
    debugPrint("Go online........");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.goOnline();

      if (response.success) {
        isDriverAvailable = true;
        final accessToken = await _storage.getAccessToken();
        final driverId = await _storage.getUserId();

        debugPrint("raccess : ${accessToken}. $driverId");
        debugPrint("driverId}. $driverId");

        SocketService().connect(accessToken!, driverId!);
      }

      debugPrint(
        "online :${response.data} ${response.message} ${response.success}",
      );
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: true, message: response.message);
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }

  /// ✅ Called from socket
  Future<void> incomingRide(RideAcceptedSocketModel data) async {
    debugPrint("📥 Incoming Ride ID: ${data.id} $data");

    incomingRideId = data.id;
    _flow = HomeFlow.newRide;

    notifyListeners();
  }

  /// Accept Ride API
  Future<ApiResponse<RideAcceptedModel>> rideAccepted(String id) async {
    debugPrint("accespted tapped");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.rideAccepted(id);

      if (response.data != null) {
        rideDetails = response.data;
        _flow = HomeFlow.rideAccepted;
        tapBottemIndex = 1;
      }

      debugPrint("accespted :${response.data} ${response.message}");
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

      debugPrint(
        "driver arrived  ${response.message}  ${response.success}:$response",
      );

      if (response.data != null) {
        _flow = HomeFlow.arrived;
      }

      debugPrint("accespted :$response");
      isLoading = false;
      notifyListeners();

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
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
      final response = await repository.journeyStart(
        incomingRideId,
        otpController.text,
      );

      debugPrint(
        "Jouerney started2....... ${response.message} ${response.success} ${response.data}",
      );

      if (response.data != null) {
        _flow = HomeFlow.jouneystarted;
      }

      debugPrint(
        "rJouerney started3 :${response.data} ${response.message} ${response.success}",
      );
      isLoading = false;
      notifyListeners();

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
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

      debugPrint(
        "Reached at the destionation ${response.message} ${response.success} ${response.data}",
      );

      if (response.data != null) {
        reachedAtLocation = response.data;
        _flow = HomeFlow.reachedDestination;
      }

      debugPrint(
        "reached destionation   :${response.data} ${response.message} ${response.success}",
      );
      isLoading = false;
      notifyListeners();

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
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
      debugPrint(
        "payemnt received ${response.message} ${response.success} ${response.data}",
      );
      if (response.data != null) {
        tapBottemIndex = 0;
        _flow=HomeFlow.idle;
      }

      debugPrint(
        "received payemnt :${response.data} ${response.message} ${response.success}",
      );
      isLoading = false;
      notifyListeners();

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }

  /// avaible Rides
  Future<ApiResponse<AvailableRides>> avilbleRdies() async {
    debugPrint("payemnt recevied tapped");

    isLoading = true;
    notifyListeners();

    try {
      final response = await repository.getAllAvaibleRides();
      debugPrint(
        "payemnt received ${response.message} ${response.success} ${response.data!.rides}",
      );
      if (response.data != null) {
         allAvailableRides.addAll(response.data!.rides);
      }

      debugPrint(
        "received payemnt :${response.data} ${response.message} ${response.success} ${allAvailableRides}",
      );
      isLoading = false;
      notifyListeners();

      return ApiResponse(
        success: true,
        message: response.message,
        data: response.data,
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();

      return ApiResponse(success: false, message: "Something went wrong: $e");
    }
  }
}
