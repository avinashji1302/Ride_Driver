class RequestDriverRegisterModel {
  final String mobile;
  final String countryCode;
  final String email;
  final String firstName;
  final String lastName;
  final String dob;
  final String primaryMobile;
  final String secondaryMobile;
  final String city;
  final String address;
  final String state;
  final String bloodGroup;
  final List<String> languages;
  final String profile;

  final String vehicleType;
  final String vehicleNumber;
  final String vehicleModel;
  final String rcNumber;
  final OwnerDetails ownerDetails;
  final bool driverIsOwner;
  final int vehicleAge;
  final bool isSafetyTested;
  final String color;
  final int seatingCapacity;

  RequestDriverRegisterModel({
    required this.mobile,
    required this.countryCode,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.primaryMobile,
    required this.secondaryMobile,
    required this.city,
    required this.address,
    required this.state,
    required this.bloodGroup,
    required this.languages,
    required this.profile,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.vehicleModel,
    required this.rcNumber,
    required this.ownerDetails,
    required this.driverIsOwner,
    required this.vehicleAge,
    required this.isSafetyTested,
    required this.color,
    required this.seatingCapacity,
  });

  factory RequestDriverRegisterModel.fromJson(Map<String, dynamic> json) {
    return RequestDriverRegisterModel(
      mobile: json['mobile'],
      countryCode: json['countryCode'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      dob: json['dob'],
      primaryMobile: json['primaryMobile'],
      secondaryMobile: json['secondaryMobile'],
      city: json['city'],
      address: json['address'],
      state: json['state'],
      bloodGroup: json['bloodGroup'],
      languages: List<String>.from(json['languages']),
      profile: json['profile'],
      vehicleType: json['vehicleType'],
      vehicleNumber: json['vehicleNumber'],
      vehicleModel: json['vehicleModel'],
      rcNumber: json['rcNumber'],
      ownerDetails: OwnerDetails.fromJson(json['ownerDetails']),
      driverIsOwner: json['driverIsOwner'],
      vehicleAge: json['vehicleAge'],
      isSafetyTested: json['isSafetyTested'],
      color: json['color'],
      seatingCapacity: json['seatingCapacity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
      "countryCode": countryCode,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "dob": dob,
      "primaryMobile": primaryMobile,
      "secondaryMobile": secondaryMobile,
      "city": city,
      "address": address,
      "state": state,
      "bloodGroup": bloodGroup,
      "languages": languages,
      "profile": profile,
      "vehicleType": vehicleType,
      "vehicleNumber": vehicleNumber,
      "vehicleModel": vehicleModel,
      "rcNumber": rcNumber,
      "ownerDetails": ownerDetails.toJson(),
      "driverIsOwner": driverIsOwner,
      "vehicleAge": vehicleAge,
      "isSafetyTested": isSafetyTested,
      "color": color,
      "seatingCapacity": seatingCapacity,
    };
  }
}


class OwnerDetails {
  final String name;
  final String mobile;

  OwnerDetails({
    required this.name,
    required this.mobile,
  });

  factory OwnerDetails.fromJson(Map<String, dynamic> json) {
    return OwnerDetails(
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "mobile": mobile,
    };
  }
}
