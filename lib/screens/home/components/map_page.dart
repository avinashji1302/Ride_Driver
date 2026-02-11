import 'package:app/screens/home/components/ride_started.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[ GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(26.9240, 75.8270)),
      ),

      if(true)
        RideStartedSheet(),
      
       
      ],
    );
  }
}
