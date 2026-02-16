import 'package:flutter/widgets.dart';

class VarifyOtpResponse {
  final Location location;
  final String id;
  final String mobile;
  final String email;
  final String firstName;
  final String lastName;
  final String city;
  final String state;
  final List<String> languages;
  final bool isAvailable;
  final String status;
  final String wallet;
  final String role;
  final String token;
  final String refreshToken;

  VarifyOtpResponse({
    required this.location,
    required this.id,
    required this.mobile,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.languages,
    required this.isAvailable,
    required this.status,
    required this.wallet,
    required this.role,
    required this.token,
    required this.refreshToken,
  });

  // factory VarifyOtpResponse.fromJson(Map<String, dynamic> data) {
  //   final data = json['results'] ?? {};

  //   debugPrint("data us : $data" );

  //      debugPrint("json result  us : ${json['results']}" );

  //   return VarifyOtpResponse(
  //     location: Location.fromJson(data['location'] ?? {}),
  //     id: data['_id'] ?? '',
  //     mobile: data['mobile'] ?? '',
  //     email: data['email'] ?? '',
  //     firstName: data['firstName'] ?? '',
  //     lastName: data['lastName'] ?? '',
  //     city: data['city'] ?? '',
  //     state: data['state'] ?? '',
  //     languages: List<String>.from(data['languages'] ?? []),
  //     isAvailable: data['isAvailable'] ?? false,
  //     status: data['status'] ?? '',
  //     wallet: (data['wallet'] ?? "0"),
  //     role: data['role'] ?? '',
  //     token: data['token'] ?? '',
  //     refreshToken: data['refreshToken'] ?? '',
  //   );
  // }

  factory VarifyOtpResponse.fromJson(Map<String, dynamic> json) {
  debugPrint("Model JSON: $json");

  return VarifyOtpResponse(
    location: Location.fromJson(json['location'] ?? {}),
    id: json['_id'] ?? '',
    mobile: json['mobile'] ?? '',
    email: json['email'] ?? '',
    firstName: json['firstName'] ?? '',
    lastName: json['lastName'] ?? '',
    city: json['city'] ?? '',
    state: json['state'] ?? '',
    languages: List<String>.from(json['languages'] ?? []),
    isAvailable: json['isAvailable'] ?? false,
    status: json['status'] ?? '',
    wallet: (json['wallet'] ?? 0).toString(),
    role: json['role'] ?? '',
    token: json['token'] ?? '',
    refreshToken: json['refreshToken'] ?? '',
  );
}

}

class Location {
  final String type;
  final double latitude;
  final double longitude;

  Location({
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    final coordinates = json['coordinates'] ?? [0.0, 0.0];

    return Location(
      type: json['type'] ?? '',
      longitude: (coordinates.isNotEmpty ? coordinates[0] : 0).toDouble(),
      latitude: (coordinates.length > 1 ? coordinates[1] : 0).toDouble(),
    );
  }
}
