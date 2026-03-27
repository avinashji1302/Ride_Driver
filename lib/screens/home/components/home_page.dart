import 'package:app/config/colors/app_color.dart';
import 'package:app/config/common/snacbar/top_snacbar.dart';
import 'package:app/screens/chat/view/chat_screen.dart';
import 'package:app/screens/home/model/availble_rides.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider controller, Widget? child) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          "https://archive.smashing.media/assets/344dbf88-fdf9-42bb-adb4-46f01eedd629/68dd54ca-60cf-4ef7-898b-26d7cbe48ec7/10-dithering-opt.jpg",
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Avinash Gupta"),
                          Card(
                            color: controller.isDriverAvailable
                                ? Colors.green
                                : Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),
                              child: controller.isDriverAvailable
                                  ? Text(
                                      "ONLINE",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      "OFFLINE",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("Balance:"),
                              Text(
                                "Rs. 2024",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const VerticalDivider(),
                          Column(
                            children: [
                              Text("Rides:"),
                              Text(
                                "3",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            children: [
                              Text("Rating:"),
                              Text(
                                "🌟 4.9",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                // SizedBox(
                //   height: 340,
                //   child: Card(
                //     child: GoogleMap(
                //       initialCameraPosition: CameraPosition(
                //         target: LatLng(26.9240, 75.8270),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 340,
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: controller.isDriverAvailable
                        ? controller.allAvailableRides.isEmpty
                              ? const Center(
                                  child: Text(
                                    "No Rides Available",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  padding: const EdgeInsets.all(12),
                                  itemCount:
                                      controller.allAvailableRides.length,
                                  itemBuilder: (context, index) {
                                    final ride =
                                        controller.allAvailableRides[index];

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 14),
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: AppColor.primaryYellow
                                              .withOpacity(0.4),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(
                                              0.06,
                                            ),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          /// Pickup
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.circle,
                                                size: 10,
                                                color: Colors.green,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  "Gopalpura Road, Jaipur",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          /// Divider Line
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 4,
                                            ),
                                            child: Container(
                                              height: 10,
                                              width: 1,
                                              color: Colors.grey.shade400,
                                            ),
                                          ),

                                          const SizedBox(height: 6),

                                          /// Drop
                                          Row(
                                            children: const [
                                              Icon(
                                                Icons.location_on,
                                                size: 18,
                                                color: Colors.red,
                                              ),
                                              SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  "Jaipur Junction, Civil Lines",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 12),

                                          /// Bottom Row
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              /// Fare
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: const [
                                                  Text(
                                                    "Estimated Fare",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "₹234",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              /// Accept Button
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColor.primaryYellow,
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 22,
                                                        vertical: 12,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  controller.rideAccepted(
                                                    ride.id,
                                                  );
                                                },
                                                child: const Text(
                                                  "Accept",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                )
                        : const Center(
                            child: Text(
                              "You are offline.\nGo online to receive ride requests.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 10),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Icon(Icons.monetization_on),
                              Text("Earnings", style: TextStyle(fontSize: 16)),
                            ],
                          ),

                          const VerticalDivider(),
                          Column(
                            children: [
                              Icon(Icons.car_rental),
                              Text("Rides", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          const VerticalDivider(),
                          Column(
                            children: [
                              Icon(Icons.support),
                              Text("Support", style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Card(
                  color: AppColor.primaryYellow,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () async {
                        final result = !controller.isDriverAvailable
                            ? await controller.goOnline()
                            : await controller.goOffline();
                        debugPrint("result : $result");
                        if (result.success) {
                          AppSnackBar.show(
                            context,
                            message: result.message,
                            backgroundColor: Colors.green,
                          );
                        } else {
                          AppSnackBar.show(
                            context,
                            message: result.message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            controller.isDriverAvailable
                                ? "Go Offline"
                                : "Go Online",
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
