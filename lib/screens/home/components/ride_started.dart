import 'package:app/config/colors/app_color.dart';
import 'package:app/config/common/snacbar/top_snacbar.dart';
import 'package:app/config/common/widgets/cylinder.dart';
import 'package:app/config/socket/socket.dart';
import 'package:app/screens/audio/view/audio_call.dart';
import 'package:app/screens/audio/view/calling_screen.dart';
import 'package:app/screens/chat/view/chat_screen.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RideStartedSheet extends StatelessWidget {
  const RideStartedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Access provider directly from context
    final controller = context.watch<HomeProvider>();
    final data = controller.rideDetails;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cylinderLine(),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.directions_car, color: Colors.yellow),
                    SizedBox(width: 8),
                    Text(
                      "You accepted the ride",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(
                        "https://www.shutterstock.com/image-photo/mid-adult-man-smiling-while-600nw-2237515123.jpg",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.rideDetails?.driver?.fullName ??
                                "name not found",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Distance : ${data?.ride?.distance}km",
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColor.grey,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 14,
                                color: AppColor.primaryYellow,
                              ),
                              SizedBox(width: 4),
                              Text(
                                data!.driverRating!.averageRating.toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                              SizedBox(width: 8),
                              Text(
                                controller.tapBottemIndex.toString(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.network(
                      "https://img.freepik.com/premium-psd/realistic-modern-car-isolated-background-3d-rendering-illustration_494250-129716.jpg?semt=ais_hybrid&w=740&q=80",
                      height: 55,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _InfoChip(
                      icon: Icons.route,
                      text: "${data.ride?.distance.toString()}km",
                    ),
                    SizedBox(width: 10),
                    _InfoChip(icon: Icons.timer, text: "18 mins ETA"),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: AppColor.primaryYellow,
                            size: 18,
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Destination",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Text(
                        data!.ride!.dropLocation!.coordinates.toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // final rideId = controller.rideDetails!.ride!.id
                        //     .toString();

                        // /// ONLY START CALL
                        // SocketService().startAudioCall(rideId);
                        final rideId = controller.rideDetails!.ride!.id
                            .toString();

                        /// START CALL
                        SocketService().startAudioCall(rideId);

                        /// 👉 SHOW CALLING UI
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => CallingScreen(rideId: rideId),
                        //   ),
                        // );
                      },
                      child: _ActionIcon(
                        icon: Icons.call,
                        label: "Call",
                        color: AppColor.primaryYellow,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ChatScreen(rideId: controller.incomingRideId),
                          ),
                        );
                      },
                      child: _ActionIcon(
                        icon: Icons.chat,
                        label: "Message Driver",
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () async {
                    final result = await controller.driverArrived();

                    debugPrint(
                      "driver arrived result : ${result.message} ${result.success} ${result.data}",
                    );
                    if (result.success) {
                      debugPrint("messsage : ${result.message} ${result.data}");

                      AppSnackBar.show(
                        context,
                        message: result.message,
                        backgroundColor: Colors.green,
                      );
                    }
                  },
                  child: Card(
                    color: AppColor.primaryYellow,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Arrived",
                            style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ... rest of the code remains the same

/// ───── ACTION ICON WIDGET
class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ActionIcon({
    required this.icon,
    required this.label,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.primaryYellow),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColor.primaryYellow),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
