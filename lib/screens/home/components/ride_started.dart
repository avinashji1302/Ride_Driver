import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class RideStartedSheet extends StatelessWidget {
   RideStartedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Access provider directly from context
    final controller = context.watch<HomeProvider>();
    
    return DraggableScrollableSheet(
      initialChildSize: 0.40,
      minChildSize: 0.25,
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.directions_car, color: Colors.yellow),
                    SizedBox(width: 8),
                    Text(
                      "Ride in progress ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 14),
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
                        children:  [
                          Text(
                            "some",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Distance : 3km",
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
                              Text("4.3", style: TextStyle(fontSize: 13)),
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
                  children: const [
                    _InfoChip(
                      icon: Icons.route,
                      text: "4 km",
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
                    children: const [
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
                        "droplocation",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    _ActionIcon(
                      icon: Icons.call,
                      label: "Call",
                      color: AppColor.primaryYellow,
                    ),
                    _ActionIcon(
                      icon: Icons.share,
                      label: "Share",
                      color: AppColor.primaryYellow,
                    ),
                    _ActionIcon(
                      icon: Icons.warning,
                      label: "Emergency",
                      color: Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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