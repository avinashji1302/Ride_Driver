import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/home/components/home_page.dart';
import 'package:app/screens/home/components/map_page.dart';
import 'package:app/screens/home/components/upcoming_ride.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeProvider>();

    final List<Widget> _pages = [
      const HomePage(),
      const MapPage(),
      const Center(child: Text("Profile Page")),
    ];

    return Scaffold(
      body: Stack(
        children: [
          _pages[controller.tapBottemIndex],

          if(controller.flow==HomeFlow.newRide)
           const UpcomingRide(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.tapBottemIndex,
        onTap: (index) {
          controller.changeTab(index);
        },
        selectedItemColor: AppColor.primaryYellow,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
