import 'dart:convert';

import 'package:app/config/networks/api_endpoints.dart';
import 'package:app/config/networks/api_reposne.dart';
import 'package:app/config/networks/http_client.dart';
import 'package:app/config/storage/auth_storage.dart';
import 'package:app/screens/home/model/ride_accepted_model.dart';

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

    final json = jsonDecode(response.body);

    return ApiResponse<RideAcceptedModel>.fromJson(
      json,
      (data) => RideAcceptedModel.fromJson(data),
    );
  }
}
