import 'package:app/config/colors/app_color.dart';
import 'package:app/config/common/snacbar/top_snacbar.dart';
import 'package:app/config/common/widgets/cylinder.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverReachedDestination extends StatelessWidget {
  const DriverReachedDestination({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeProvider>();
    final rideDetails = controller.rideDetails;
    final data = controller.reachedAtLocation;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.35,
      maxChildSize: 0.85,
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
                SizedBox(height: 10),

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.flag, color: AppColor.primaryYellow),
                    SizedBox(width: 8),
                    Text(
                      "Reached Destination",
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
                        data?.ride.driver ?? "Customer Name",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          rideDetails?.driver?.rating.toString() ??
                              "null found",
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// TRIP SUMMARY
                const Text(
                  "Trip Summary",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 10),

                _summaryTile(
                  icon: Icons.route,
                  title: "Total Distance",
                  value: "${data?.ride.distance ?? 8} km",
                ),

                _summaryTile(
                  icon: Icons.timer,
                  title: "Total Time",
                  value: "22 mins",
                ),

                _summaryTile(
                  icon: Icons.currency_rupee,
                  title: "Final Fare",
                  value: "₹${data?.ride.finalFare ?? 0.0}",
                ),

                _summaryTile(
                  icon: Icons.payment,
                  title: "Payment Mode",
                  value: rideDetails!.ride!.paymentMethod.toString(),
                ),

                const SizedBox(height: 24),

                /// COLLECT CASH (if cash ride)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.amber),
                  ),
                  child: Row(
                    children:  [
                      Icon(Icons.info_outline, color: Colors.amber),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "Collect ₹${data?.ride.finalFare} from rider",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// COMPLETE TRIP BUTTON
                GestureDetector(
                  onTap: () async {
                    final result = await controller.revievedPayemnt();

                    debugPrint(
                      "payemnt : ${result} ${result.data} ${result.message} ${result.success}",
                    );

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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColor.primaryYellow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        "Complete Trip",
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

  Widget _summaryTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColor.primaryYellow),
          const SizedBox(width: 10),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
