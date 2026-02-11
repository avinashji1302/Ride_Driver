class RideAcceptedModel {
  final Ride? ride;
  final String? otp;
  final Driver? driver;
  final Vehicle? vehicle;
  final DriverRating? driverRating;

  RideAcceptedModel({
    this.ride,
    this.otp,
    this.driver,
    this.vehicle,
    this.driverRating,
  });

  factory RideAcceptedModel.fromJson(Map<String, dynamic> json) {
    return RideAcceptedModel(
      ride: json['ride'] != null ? Ride.fromJson(json['ride']) : null,
      otp: json['otp'],
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      vehicle:
          json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null,
      driverRating: json['driverRating'] != null
          ? DriverRating.fromJson(json['driverRating'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ride': ride?.toJson(),
      'otp': otp,
      'driver': driver?.toJson(),
      'vehicle': vehicle?.toJson(),
      'driverRating': driverRating?.toJson(),
    };
  }
}


class Ride {
  final String? id;
  final Location? pickupLocation;
  final Location? dropLocation;
  final PaymentDetails? paymentDetails;
  final String? driver;
  final String? rider;
  final double? distance;
  final double? finalFare;
  final double? originalFare;
  final double? discountAmount;
  final String? paymentMethod;
  final String? status;
  final String? otpForRideStart;
  final int? estimatedTime;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? vehicleType;

  Ride({
    this.id,
    this.pickupLocation,
    this.dropLocation,
    this.paymentDetails,
    this.driver,
    this.rider,
    this.distance,
    this.finalFare,
    this.originalFare,
    this.discountAmount,
    this.paymentMethod,
    this.status,
    this.otpForRideStart,
    this.estimatedTime,
    this.createdAt,
    this.updatedAt,
    this.vehicleType,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['_id'],
      pickupLocation: json['pickupLocation'] != null
          ? Location.fromJson(json['pickupLocation'])
          : null,
      dropLocation: json['dropLocation'] != null
          ? Location.fromJson(json['dropLocation'])
          : null,
      paymentDetails: json['paymentDetails'] != null
          ? PaymentDetails.fromJson(json['paymentDetails'])
          : null,
      driver: json['driver'],
      rider: json['rider'],
      distance: (json['distance'] as num?)?.toDouble(),
      finalFare: (json['finalFare'] as num?)?.toDouble(),
      originalFare: (json['originalFare'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'],
      status: json['status'],
      otpForRideStart: json['otpForRideStart'],
      estimatedTime: json['estimatedTime'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
      vehicleType: json['vehicleType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'pickupLocation': pickupLocation?.toJson(),
      'dropLocation': dropLocation?.toJson(),
      'paymentDetails': paymentDetails?.toJson(),
      'driver': driver,
      'rider': rider,
      'distance': distance,
      'finalFare': finalFare,
      'originalFare': originalFare,
      'discountAmount': discountAmount,
      'paymentMethod': paymentMethod,
      'status': status,
      'otpForRideStart': otpForRideStart,
      'estimatedTime': estimatedTime,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'vehicleType': vehicleType,
    };
  }
}


class Location {
  final String? address;
  final String? type;
  final List<double>? coordinates;

  Location({this.address, this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      address: json['address'],
      type: json['type'],
      coordinates: (json['coordinates'] as List?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'type': type,
      'coordinates': coordinates,
    };
  }
}


class PaymentDetails {
  final double? userPaidAmount;
  final double? driverReceivedAmount;
  final double? adminCommissionAmount;
  final double? discountAmount;
  final double? originalFare;

  PaymentDetails({
    this.userPaidAmount,
    this.driverReceivedAmount,
    this.adminCommissionAmount,
    this.discountAmount,
    this.originalFare,
  });

  factory PaymentDetails.fromJson(Map<String, dynamic> json) {
    return PaymentDetails(
      userPaidAmount: (json['userPaidAmount'] as num?)?.toDouble(),
      driverReceivedAmount:
          (json['driverReceivedAmount'] as num?)?.toDouble(),
      adminCommissionAmount:
          (json['adminCommissionAmount'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      originalFare: (json['originalFare'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userPaidAmount': userPaidAmount,
      'driverReceivedAmount': driverReceivedAmount,
      'adminCommissionAmount': adminCommissionAmount,
      'discountAmount': discountAmount,
      'originalFare': originalFare,
    };
  }
}


class Driver {
  final String? id;
  final String? fullName;
  final String? mobile;
  final String? countryCode;
  final double? rating;

  Driver({
    this.id,
    this.fullName,
    this.mobile,
    this.countryCode,
    this.rating,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['_id'],
      fullName: json['fullName'],
      mobile: json['mobile'],
      countryCode: json['countryCode'],
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'mobile': mobile,
      'countryCode': countryCode,
      'rating': rating,
    };
  }
}

class Vehicle {
  final String? id;
  final String? type;
  final String? number;
  final String? model;
  final String? color;

  Vehicle({
    this.id,
    this.type,
    this.number,
    this.model,
    this.color,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['_id'],
      type: json['type'],
      number: json['number'],
      model: json['model'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'number': number,
      'model': model,
      'color': color,
    };
  }
}

class DriverRating {
  final double? averageRating;
  final int? ratingCount;
  final List<Rating>? ratings;

  DriverRating({
    this.averageRating,
    this.ratingCount,
    this.ratings,
  });

  factory DriverRating.fromJson(Map<String, dynamic> json) {
    return DriverRating(
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      ratingCount: json['ratingCount'],
      ratings: (json['ratings'] as List?)
          ?.map((e) => Rating.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'averageRating': averageRating,
      'ratingCount': ratingCount,
      'ratings': ratings?.map((e) => e.toJson()).toList(),
    };
  }
}

class Rating {
  final int? rating;
  final String? message;
  final DateTime? createdAt;

  Rating({this.rating, this.message, this.createdAt});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rating: json['rating'],
      message: json['message'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'message': message,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
