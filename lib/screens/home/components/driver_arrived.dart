import 'package:app/config/colors/app_color.dart';
import 'package:app/config/common/widgets/common_text_field.dart';
import 'package:app/config/common/widgets/cylinder.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class DriverArrived extends StatefulWidget {
  const DriverArrived({super.key});

  @override
  State<DriverArrived> createState() => _DriverArrivedState();
}

class _DriverArrivedState extends State<DriverArrived> {
  final TextEditingController otpController = TextEditingController();
  bool isOtpVerified = false;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeProvider>();
    final data = controller.rideDetails;

    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.35,
      maxChildSize: 0.90,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cylinderLine(),
                const SizedBox(height: 12),

                /// ARRIVED HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check_circle, color: AppColor.primaryYellow),
                   SizedBox(height: 10),
                    Text(
                      "You’ve Arrived",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const Divider(),

                /// CUSTOMER INFO
                Row(
                  children: [
                    const CircleAvatar(radius: 24, child: Icon(Icons.person)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        data?.driver?.fullName ?? "Customer Name",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text("4.8"),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// OTP SECTION
                const Text(
                  "Enter Rider OTP",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                const SizedBox(height: 8),

                CommonTextField(hintText: 'Enter 4 digit OTP' , controller: controller.otpController,),
                const SizedBox(width: 10),

                const SizedBox(height: 20),

                /// TRIP DETAILS
                const Text(
                  "Trip Details",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),

                _tripTile(
                  icon: Icons.my_location,
                  title: "Pickup",
                  value: "Current Location (Auto)",
                ),

                _tripTile(
                  icon: Icons.location_on,
                  title: "Drop",
                  value: "MG Road, Bangalore",
                ),

                _tripTile(icon: Icons.payment, title: "Payment", value: "Cash"),

                _tripTile(
                  icon: Icons.currency_rupee,
                  title: "Estimated Fare",
                  value: "₹245",
                ),

                const SizedBox(height: 24),

                /// START RIDE BUTTON
                GestureDetector(
                  onTap: () async{
                   final result = await controller.jouneystarted();

                   if(result.success){
                    debugPrint("result ; ${result.data}");
                   }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColor.primaryYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "Start Ride",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
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

  Widget _tripTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColor.primaryYellow),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
