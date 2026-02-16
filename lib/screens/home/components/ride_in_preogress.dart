import 'package:app/config/colors/app_color.dart';
import 'package:app/config/common/widgets/cylinder.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class RideInProgress extends StatelessWidget {
  const RideInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeProvider>();
    final data = controller.rideDetails;

    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.30,
      maxChildSize: 0.85,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// drag line
                cylinderLine(),
                SizedBox(height: 10),

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.directions_car,  color: AppColor.primaryYellow),
                    SizedBox(width: 8),
                    Text(
                      "Ride In Progress",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

               
                const Divider(),

                /// RIDER INFO
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      child: Icon(Icons.person),
                    ),
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
                    IconButton(
                      onPressed: () {
                        /// call rider
                      },
                      icon: const Icon(Icons.call, color: Colors.green),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// LIVE STATUS CARD
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColor.primaryYellow)
                  ),
                  child: Column(
                    children: [
                      _statusRow(
                        icon: Icons.route,
                        title: "Remaining Distance",
                        value: "${data?.ride?.distance ?? 5} km",
                      ),
                      const SizedBox(height: 12),
                      _statusRow(
                        icon: Icons.timer,
                        title: "Estimated Time",
                        value: "12 mins",
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// DROP LOCATION
                const Text(
                  "Drop Location",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on, color: AppColor.primaryYellow),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          data?.ride?.dropLocation?.coordinates
                                  ?.toString() ??
                              "MG Road, Bangalore",
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                /// END RIDE BUTTON
                GestureDetector(
                  onTap: () async {
                    /// move to reached destination screen
                    /// 
                  final result = await  controller.reachedDestination();

                  debugPrint("reaced :::: ${result} ${result.data}. ${result.message} ${result.success}");

                  if(result.success){
                    debugPrint("success reached destionation");
                  }
                  },
                  child: Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColor.primaryYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "End Ride",
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

  Widget _statusRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColor.primaryYellow),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
