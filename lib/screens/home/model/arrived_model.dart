
//arrived and started both has same field no diffenrce...........use same for both......


import 'package:flutter/material.dart';

class ArrivedModel {
  final Ride ride;

  ArrivedModel({required this.ride});

  factory ArrivedModel.fromJson(Map<String, dynamic> json) {
    debugPrint("ArrivedModel.fromJson received: $json");
  debugPrint("Ride data: ${json['ride']}");
  
    return ArrivedModel(
      ride: Ride.fromJson(json['ride'] ?? {}),
    );
  }
}



class Ride {
  final String id;
  final LocationModel pickupLocation;
  final LocationModel dropLocation;
  final PaymentDetails paymentDetails;

  final String driver;
  final String rider;

  // 🔥 All numbers converted to String
  final String distance;
  final String finalFare;
  final String originalFare;
  final String discountAmount;
  final String cancellationPenalty;
  final String surgeMultiplier;
  final String estimatedTime;
  final String actualTime;

  final String paymentMethod;
  final String status;
  final String vehicleType;
  final String otpForRideStart;

  final bool isScheduled;
  final bool reminderSent;
  final bool autoCancelled;
  final bool paidToDriver;
  final bool paidToAdmin;
  final bool paymentSuccessful;
  final bool cashPaidByUser;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? actualArrivalTime;
  final DateTime? actualCompletionTime;

  Ride({
    required this.id,
    required this.pickupLocation,
    required this.dropLocation,
    required this.paymentDetails,
    required this.driver,
    required this.rider,
    required this.distance,
    required this.finalFare,
    required this.originalFare,
    required this.discountAmount,
    required this.cancellationPenalty,
    required this.surgeMultiplier,
    required this.estimatedTime,
    required this.actualTime,
    required this.paymentMethod,
    required this.status,
    required this.vehicleType,
    required this.otpForRideStart,
    required this.isScheduled,
    required this.reminderSent,
    required this.autoCancelled,
    required this.paidToDriver,
    required this.paidToAdmin,
    required this.paymentSuccessful,
    required this.cashPaidByUser,
    this.createdAt,
    this.updatedAt,
    this.actualArrivalTime,
    this.actualCompletionTime,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json["_id"]?.toString() ?? "",

      pickupLocation:
          LocationModel.fromJson(json["pickupLocation"] ?? {}),
      dropLocation:
          LocationModel.fromJson(json["dropLocation"] ?? {}),
      paymentDetails:
          PaymentDetails.fromJson(json["paymentDetails"] ?? {}),

      driver: json["driver"]?.toString() ?? "",
      rider: json["rider"]?.toString() ?? "",

      // 🔥 Numbers safely converted to String
      distance: json["distance"]?.toString() ?? "0",
      finalFare: json["finalFare"]?.toString() ?? "0",
      originalFare: json["originalFare"]?.toString() ?? "0",
      discountAmount: json["discountAmount"]?.toString() ?? "0",
      cancellationPenalty:
          json["cancellationPenalty"]?.toString() ?? "0",
      surgeMultiplier:
          json["surgeMultiplier"]?.toString() ?? "1",
      estimatedTime:
          json["estimatedTime"]?.toString() ?? "0",
      actualTime:
          json["actualTime"]?.toString() ?? "0",

      paymentMethod: json["paymentMethod"] ?? "",
      status: json["status"] ?? "",
      vehicleType: json["vehicleType"] ?? "",
      otpForRideStart: json["otpForRideStart"] ?? "",

      isScheduled: json["isScheduled"] ?? false,
      reminderSent: json["reminderSent"] ?? false,
      autoCancelled: json["autoCancelled"] ?? false,
      paidToDriver: json["paidToDriver"] ?? false,
      paidToAdmin: json["paidToAdmin"] ?? false,
      paymentSuccessful: json["paymentSuccessful"] ?? false,
      cashPaidByUser: json["cashPaidByUser"] ?? false,

      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
      actualArrivalTime: json["actualArrivalTime"] != null
          ? DateTime.tryParse(json["actualArrivalTime"])
          : null,
      actualCompletionTime:
          json["actualCompletionTime"] != null
              ? DateTime.tryParse(json["actualCompletionTime"])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "pickupLocation": pickupLocation.toJson(),
        "dropLocation": dropLocation.toJson(),
        "paymentDetails": paymentDetails.toJson(),
        "driver": driver,
        "rider": rider,
        "distance": distance,
        "finalFare": finalFare,
        "originalFare": originalFare,
        "discountAmount": discountAmount,
        "cancellationPenalty": cancellationPenalty,
        "surgeMultiplier": surgeMultiplier,
        "estimatedTime": estimatedTime,
        "actualTime": actualTime,
        "paymentMethod": paymentMethod,
        "status": status,
        "vehicleType": vehicleType,
        "otpForRideStart": otpForRideStart,
        "isScheduled": isScheduled,
        "reminderSent": reminderSent,
        "autoCancelled": autoCancelled,
        "paidToDriver": paidToDriver,
        "paidToAdmin": paidToAdmin,
        "paymentSuccessful": paymentSuccessful,
        "cashPaidByUser": cashPaidByUser,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "actualArrivalTime":
            actualArrivalTime?.toIso8601String(),
        "actualCompletionTime":
            actualCompletionTime?.toIso8601String(),
      };
}

class LocationModel {
  final String type;
  final List<String> coordinates;
  final String address;

  LocationModel({
    required this.type,
    required this.coordinates,
    required this.address,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json["type"] ?? "",
      coordinates: json["coordinates"] != null
          ? List<String>.from(
              json["coordinates"].map((x) => x.toString()))
          : [],
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates,
        "address": address,
      };
}

class PaymentDetails {
  final String userPaidAmount;
  final String driverReceivedAmount;
  final String adminCommissionAmount;
  final String discountAmount;
  final String originalFare;
  final String? promoCode;
  final DateTime? paymentCompletedAt;

  PaymentDetails({
    required this.userPaidAmount,
    required this.driverReceivedAmount,
    required this.adminCommissionAmount,
    required this.discountAmount,
    required this.originalFare,
    this.promoCode,
    this.paymentCompletedAt,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      userPaidAmount: json["userPaidAmount"]?.toString() ?? "0",
      driverReceivedAmount:
          json["driverReceivedAmount"]?.toString() ?? "0",
      adminCommissionAmount:
          json["adminCommissionAmount"]?.toString() ?? "0",
      discountAmount:
          json["discountAmount"]?.toString() ?? "0",
      originalFare:
          json["originalFare"]?.toString() ?? "0",
      promoCode: json["promoCode"]?.toString(),
      paymentCompletedAt:
          json["paymentCompletedAt"] != null
              ? DateTime.tryParse(json["paymentCompletedAt"])
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "userPaidAmount": userPaidAmount,
        "driverReceivedAmount": driverReceivedAmount,
        "adminCommissionAmount": adminCommissionAmount,
        "discountAmount": discountAmount,
        "originalFare": originalFare,
        "promoCode": promoCode,
        "paymentCompletedAt":
            paymentCompletedAt?.toIso8601String(),
      };
}
