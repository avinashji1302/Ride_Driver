class RegisterModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String countryCode;

  final String primaryMobile;
  final String secondaryMobile;

  final String dob;
  final String bloodGroup;

  final String city;
  final String state;
  final String address;

  final List<String> languages;
  final String profile;

  final bool driverIsOwner;
  final String vehicleAge;
  final bool isSafetyTested;
  final String color;
  final String seatingCapacity;

  final String status;

  final DateTime createdAt;
  final DateTime updatedAt;

  final DriverLocation? location;

  RegisterModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.countryCode,
    required this.primaryMobile,
    required this.secondaryMobile,
    required this.dob,
    required this.bloodGroup,
    required this.city,
    required this.state,
    required this.address,
    required this.languages,
    required this.profile,
    required this.driverIsOwner,
    required this.vehicleAge,
    required this.isSafetyTested,
    required this.color,
    required this.seatingCapacity,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.location,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      countryCode: json['countryCode'] ?? '',
      primaryMobile: json['primaryMobile'] ?? '',
      secondaryMobile: json['secondaryMobile'] ?? '',
      dob: json['dob'] ?? '',
      bloodGroup: json['bloodGroup'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      address: json['address'] ?? '',
      languages: (json['languages'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      profile: json['profile'] ?? '',
      driverIsOwner: json['driverIsOwner'] ?? false,
      vehicleAge: (json['vehicleAge'] ) ?? "0",
      isSafetyTested: json['isSafetyTested'] ?? false,
      color: json['color'] ?? '',
      seatingCapacity: (json['seatingCapacity']) ?? "0",
      status: json['status'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      location:
          json['location'] != null ? DriverLocation.fromJson(json['location']) : null,
    );
  }
}


class DriverLocation {
  final String type;
  final List<double> coordinates;

  DriverLocation({
    required this.type,
    required this.coordinates,
  });

  factory DriverLocation.fromJson(Map<String, dynamic> json) {
    return DriverLocation(
      type: json['type'] ?? 'Point',
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}
