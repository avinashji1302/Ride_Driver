class RideAcceptedSocketModel {
  final String id;
  final String rider;
  final String? driver;

  final Location pickupLocation;
  final Location dropLocation;

  final String distance;
  final String finalFare;
  final String originalFare;
  final String discountAmount;
  final String cancellationPenalty;
  final String surgeMultiplier;

  final String paymentMethod;
  final String status;

  final String estimatedTime;
  final String actualTime;

  final bool isScheduled;
  final bool paidToDriver;
  final bool paidToAdmin;
  final bool paymentSuccessful;
  final bool cashPaidByUser;

  final PaymentDetails paymentDetails;

  RideAcceptedSocketModel({
    required this.id,
    required this.rider,
    required this.driver,
    required this.pickupLocation,
    required this.dropLocation,
    required this.distance,
    required this.finalFare,
    required this.originalFare,
    required this.discountAmount,
    required this.cancellationPenalty,
    required this.surgeMultiplier,
    required this.paymentMethod,
    required this.status,
    required this.estimatedTime,
    required this.actualTime,
    required this.isScheduled,
    required this.paidToDriver,
    required this.paidToAdmin,
    required this.paymentSuccessful,
    required this.cashPaidByUser,
    required this.paymentDetails,
  });

  factory RideAcceptedSocketModel.fromJson(Map<String, dynamic> json) {
    return RideAcceptedSocketModel(
      id: json['_id']?.toString() ?? '',
      rider: json['rider']?.toString() ?? '',
      driver: json['driver']?.toString(),

      pickupLocation:
          Location.fromJson(json['pickupLocation'] ?? {}),
      dropLocation:
          Location.fromJson(json['dropLocation'] ?? {}),

      distance: json['distance']?.toString() ?? '0',
      finalFare: json['finalFare']?.toString() ?? '0',
      originalFare: json['originalFare']?.toString() ?? '0',
      discountAmount: json['discountAmount']?.toString() ?? '0',
      cancellationPenalty:
          json['cancellationPenalty']?.toString() ?? '0',
      surgeMultiplier:
          json['surgeMultiplier']?.toString() ?? '1',

      paymentMethod: json['paymentMethod']?.toString() ?? '',
      status: json['status']?.toString() ?? '',

      estimatedTime: json['estimatedTime']?.toString() ?? '0',
      actualTime: json['actualTime']?.toString() ?? '0',

      isScheduled: json['isScheduled'] ?? false,
      paidToDriver: json['paidToDriver'] ?? false,
      paidToAdmin: json['paidToAdmin'] ?? false,
      paymentSuccessful: json['paymentSuccessful'] ?? false,
      cashPaidByUser: json['cashPaidByUser'] ?? false,

      paymentDetails:
          PaymentDetails.fromJson(json['paymentDetails'] ?? {}),
    );
  }
}

class Location {
  final String type;
  final List<String> coordinates;
  final String? address;

  Location({
    required this.type,
    required this.coordinates,
    this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type']?.toString() ?? 'Point',
      coordinates:
          (json['coordinates'] as List<dynamic>? ?? [])
              .map((e) => e.toString())
              .toList(),
      address: json['address']?.toString(),
    );
  }
}

class PaymentDetails {
  final String userPaidAmount;
  final String driverReceivedAmount;
  final String adminCommissionAmount;
  final String discountAmount;
  final String originalFare;
  final String? promoCode;
  final String? paymentCompletedAt;

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
      userPaidAmount:
          json['userPaidAmount']?.toString() ?? '0',
      driverReceivedAmount:
          json['driverReceivedAmount']?.toString() ?? '0',
      adminCommissionAmount:
          json['adminCommissionAmount']?.toString() ?? '0',
      discountAmount:
          json['discountAmount']?.toString() ?? '0',
      originalFare:
          json['originalFare']?.toString() ?? '0',
      promoCode: json['promoCode']?.toString(),
      paymentCompletedAt:
          json['paymentCompletedAt']?.toString(),
    );
  }
}
