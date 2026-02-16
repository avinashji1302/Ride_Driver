import 'dart:convert';

import 'package:app/config/networks/api_endpoints.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/networks/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/home/model/arrived_model.dart';
import 'package:app/screens/home/model/ride_accepted_model.dart';
import 'package:flutter/cupertino.dart';

class HomeRepository {
  //ride accedpted

  Future<ApiResponse<RideAcceptedModel>> rideAccepted(String rideId) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      ApiEndpoints.rideAccepted,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"rideId": rideId},
    );
        debugPrint("  ride accepted raw data is : $response");

    final json = jsonDecode(response.body);

    return ApiResponse<RideAcceptedModel>.fromJson(
      json,
      (data) => RideAcceptedModel.fromJson(data),
    );
  }

  //-----------------------------arrived----------------------------------
  Future<ApiResponse<ArrivedModel>> arrived(String rideId) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      ApiEndpoints.arrived,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"rideId": rideId},
    );

    debugPrint(" arrived raw data is : ${response.body}");
    final json = jsonDecode(response.body);

    return ApiResponse<ArrivedModel>.fromJson(
      json,
      (data) => ArrivedModel.fromJson(data),
    );
  }

  //---------------------------- Start the ride-----------------------------------


  Future<ApiResponse<ArrivedModel>> journeyStart(String rideId , String otp) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      ApiEndpoints.startJourney,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"rideId": rideId,"otp": otp},
    );

    debugPrint(" journey started raw data is : ${response.body}");

    final json = jsonDecode(response.body);

    return ApiResponse<ArrivedModel>.fromJson(
      json,
      (data) => ArrivedModel.fromJson(data),
    );
  }



  //---------------------------- Reached at  the destination -----------------------------------


  Future<ApiResponse<ArrivedModel>> reachedAtDestination(String rideId ) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      ApiEndpoints.reachedDestination,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"rideId": rideId},
    );

    debugPrint(" reached at the desination : ${response.body}");

    final json = jsonDecode(response.body);

    return ApiResponse<ArrivedModel>.fromJson(
      json,
      (data) => ArrivedModel.fromJson(data),
    );
  }


    //---------------------------- recieved payment -----------------------------------


  Future<ApiResponse<ArrivedModel>> recievedPayment(String rideId ) async {
    final token = await AuthStorage().getAccessToken();

    final response = await HttpClient.post(
      ApiEndpoints.receivedPayment,
      headers: {
        "Accept": "application/json",
        "Content-type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: {"rideId": rideId},
    );

    debugPrint(" journey started raw data is : ${response.body}");

    final json = jsonDecode(response.body);

    return ApiResponse<ArrivedModel>.fromJson(
      json,
      (data) => ArrivedModel.fromJson(data),
    );
  }
}
