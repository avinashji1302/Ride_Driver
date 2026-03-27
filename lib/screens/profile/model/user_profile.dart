class UserProfileModel {
  final DriverModel? driver;
  final VehicleModel? vehicle;
  final dynamic activeRide;

  UserProfileModel({
    this.driver,
    this.vehicle,
    this.activeRide,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      driver:
          json['driver'] != null ? DriverModel.fromJson(json['driver']) : null,
      vehicle:
          json['vehicle'] != null ? VehicleModel.fromJson(json['vehicle']) : null,
      activeRide: json['activeRide'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "driver": driver?.toJson(),
      "vehicle": vehicle?.toJson(),
      "activeRide": activeRide,
    };
  }
}

// ================= DRIVER =================

class DriverModel {
  final String id;
  final String mobile;
  final String email;
  final String firstName;
  final String lastName;
  final String dob;
  final String countryCode;
  final String primaryMobile;
  final String secondaryMobile;
  final String bloodGroup;
  final String city;
  final String address;
  final String state;
  final List<String> languages;
  final String profile;
  final String deviceId;
  final String deviceToken;
  final LocationModel? location;
  final String h3Index;
  final String wallet;
  final String driverCommission;
  final String isAvailable;
  final String registrationStatus;
  final String isDeleted;
  final String rejectionReason;
  final String status;
  final String role;
  final String isEmailVerified;
  final String isMobileVerified;
  final String notifications;
  final String penalties;
  final String rating;
  final String ratingCount;
  final String createdAt;
  final String updatedAt;

  DriverModel({
    required this.id,
    required this.mobile,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.countryCode,
    required this.primaryMobile,
    required this.secondaryMobile,
    required this.bloodGroup,
    required this.city,
    required this.address,
    required this.state,
    required this.languages,
    required this.profile,
    required this.deviceId,
    required this.deviceToken,
    this.location,
    required this.h3Index,
    required this.wallet,
    required this.driverCommission,
    required this.isAvailable,
    required this.registrationStatus,
    required this.isDeleted,
    required this.rejectionReason,
    required this.status,
    required this.role,
    required this.isEmailVerified,
    required this.isMobileVerified,
    required this.notifications,
    required this.penalties,
    required this.rating,
    required this.ratingCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['_id']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      dob: json['dob']?.toString() ?? '',
      countryCode: json['countryCode']?.toString() ?? '',
      primaryMobile: json['primaryMobile']?.toString() ?? '',
      secondaryMobile: json['secondaryMobile']?.toString() ?? '',
      bloodGroup: json['bloodGroup']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      state: json['state']?.toString() ?? '',
      languages: (json['languages'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      profile: json['profile']?.toString() ?? '',
      deviceId: json['deviceId']?.toString() ?? '',
      deviceToken: json['deviceToken']?.toString() ?? '',
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      h3Index: json['h3Index']?.toString() ?? '',
      wallet: json['wallet']?.toString() ?? '',
      driverCommission: json['driverCommission']?.toString() ?? '',
      isAvailable: json['isAvailable']?.toString() ?? '',
      registrationStatus: json['registrationStatus']?.toString() ?? '',
      isDeleted: json['isDeleted']?.toString() ?? '',
      rejectionReason: json['rejectionReason']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      isEmailVerified: json['isEmailVerified']?.toString() ?? '',
      isMobileVerified: json['isMobileVerified']?.toString() ?? '',
      notifications: json['notifications']?.toString() ?? '',
      penalties: json['penalties']?.toString() ?? '',
      rating: json['rating']?.toString() ?? '',
      ratingCount: json['ratingCount']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "mobile": mobile,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}

// ================= VEHICLE =================

class VehicleModel {
  final String id;
  final String driver;
  final String type;
  final String number;
  final String model;
  final String rcNumber;
  final String driverIsOwner;
  final String vehicleAge;
  final String isSafetyTested;
  final String color;
  final String seatingCapacity;
  final String status;
  final String createdAt;
  final String updatedAt;

  VehicleModel({
    required this.id,
    required this.driver,
    required this.type,
    required this.number,
    required this.model,
    required this.rcNumber,
    required this.driverIsOwner,
    required this.vehicleAge,
    required this.isSafetyTested,
    required this.color,
    required this.seatingCapacity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['_id']?.toString() ?? '',
      driver: json['driver']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      model: json['model']?.toString() ?? '',
      rcNumber: json['rcNumber']?.toString() ?? '',
      driverIsOwner: json['driverIsOwner']?.toString() ?? '',
      vehicleAge: json['vehicleAge']?.toString() ?? '',
      isSafetyTested: json['isSafetyTested']?.toString() ?? '',
      color: json['color']?.toString() ?? '',
      seatingCapacity: json['seatingCapacity']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "number": number,
      "model": model,
    };
  }
}

// ================= LOCATION =================

class LocationModel {
  final String type;
  final List<String> coordinates;

  LocationModel({
    required this.type,
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      type: json['type']?.toString() ?? '',
      coordinates: (json['coordinates'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }
}