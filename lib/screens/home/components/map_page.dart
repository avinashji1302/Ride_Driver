import 'package:app/screens/home/components/driver_arrived.dart';
import 'package:app/screens/home/components/reached_destination.dart';
import 'package:app/screens/home/components/ride_in_preogress.dart';
import 'package:app/screens/home/components/ride_started.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (BuildContext context, HomeProvider controller, Widget? child) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(26.9240, 75.8270),
              ),
            ),

            if (controller.flow == HomeFlow.rideAccepted) RideStartedSheet(),

            if (controller.flow == HomeFlow.arrived) DriverArrived(),
            //  if (true) DriverArrived(),

            if (controller.flow == HomeFlow.jouneystarted) RideInProgress(),
            //  if (true) RideInProgress(),

            if (controller.flow == HomeFlow.reachedDestination)
              DriverReachedDestination(),

              // if (true)
              // DriverReachedDestination(),
          ],
        );
      },
    );
  }
}
