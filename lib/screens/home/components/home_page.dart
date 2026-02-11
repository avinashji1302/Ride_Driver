import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider value, Widget? child) {
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
                              color: AppColor.primaryYellow,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 5,
                                ),
                                child: Text("ONLINE"),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [Icon(Icons.wifi), Icon(Icons.circle)],
                        ),
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
                  SizedBox(
                    height: 340,
                    child: Card(
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(26.9240, 75.8270),
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
                                Text(
                                  "Earnings",
                                  style: TextStyle(fontSize: 16),
                                ),
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
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Go Offline",
                            style: TextStyle(
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
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