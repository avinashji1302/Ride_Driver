// class AvailableRidesResponse {
//   final bool success;
//   final String message;
//   final AvailableRides? results;

//   AvailableRidesResponse({
//     required this.success,
//     required this.message,
//     this.results,
//   });

//   factory AvailableRidesResponse.fromJson(Map<String, dynamic> json) {
//     return AvailableRidesResponse(
//       success: json['success'] ?? false,
//       message: json['message'] ?? '',
//       results: json['results'] != null
//           ? AvailableRides.fromJson(json['results'])
//           : null,
//     );
//   }
// }

class AvailableRides {
  final List<AllRides> rides;
  // final int count;

  AvailableRides({
    required this.rides,
    // required this.count,
  });

  factory AvailableRides.fromJson(Map<String, dynamic> json) {
    return AvailableRides(
      rides: json['rides'] != null
          ? List<AllRides>.from(
              json['rides'].map((x) => AllRides.fromJson(x)),
            )
          : [],
      // count: json['count'] ?? 0,
    );
  }
}

// class AllRides{
//   final String? id;
//   final String? driverName;
//   final String? pickupLocation;
//   final String? dropLocation;

//   AllRides({
//     this.id,
//     this.driverName,
//     this.pickupLocation,
//     this.dropLocation,
//   });

//   factory AllRides.fromJson(Map<String, dynamic> json) {
//     return AllRides(
//       id: json['_id'],
//       driverName: json['driverName'],
//       pickupLocation: json['pickupLocation'],
//       dropLocation: json['dropLocation'],
//     );
//   }
// }

class AllRides {
  final String id;
  final String status;
  final double distance;
  final double finalFare;
  final double originalFare;
  final String paymentMethod;
  final String vehicleType;
  final int estimatedTime;

  final Rider rider;
  final Location pickupLocation;
  final Location dropLocation;

  AllRides({
    required this.id,
    required this.status,
    required this.distance,
    required this.finalFare,
    required this.originalFare,
    required this.paymentMethod,
    required this.vehicleType,
    required this.estimatedTime,
    required this.rider,
    required this.pickupLocation,
    required this.dropLocation,
  });

  factory AllRides.fromJson(Map<String, dynamic> json) {
    return AllRides(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      distance: (json['distance'] ?? 0).toDouble(),
      finalFare: (json['finalFare'] ?? 0).toDouble(),
      originalFare: (json['originalFare'] ?? 0).toDouble(),
      paymentMethod: json['paymentMethod'] ?? '',
      vehicleType: json['vehicleType'] ?? '',
      estimatedTime: json['estimatedTime'] ?? 0,
      rider: Rider.fromJson(json['rider'] ?? {}),
      pickupLocation: Location.fromJson(json['pickupLocation'] ?? {}),
      dropLocation: Location.fromJson(json['dropLocation'] ?? {}),
    );
  }
}

class Rider {
  final String id;
  final String firstName;
  final String lastName;
  final String mobile;
  final String email;

  Rider({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
  });

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
      id: json['_id'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
class Location {
  final String type;
  final String address;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.address,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      address: json['address'] ?? '',
      coordinates: (json['coordinates'] as List? ?? [])
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}
