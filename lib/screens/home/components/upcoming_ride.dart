import 'package:app/config/colors/app_color.dart';
import 'package:flutter/material.dart';

class UpcomingRide extends StatelessWidget {
  const UpcomingRide({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 240,
      left: 16,
      right: 16, // ✅ Bounds the width for Expanded to work
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.yellow),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.yellow.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16,
                    color: Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Upcoming ride',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Driver Info Row
            Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(
                    "https://www.shutterstock.com/image-photo/mid-adult-man-smiling-while-600nw-2237515123.jpg",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  // ✅ Direct child of Row - no widgets in between
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Mukesh S.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Distance : 3km",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 14,
                            color: Colors.yellow.shade700,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            "4.7",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Pickup Location
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Gopalpura Road, Jaipur",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Drop Location
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "Jaipur Junction, Civil Lines, Jaipur",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Estimated Fare
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estimated fare',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
                const Text(
                  '₹234',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            Row(children: [
              Expanded(
                child: Card(
                      color: AppColor.primaryYellow,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Accept",
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

                  SizedBox(width: 10,),
                  Expanded(
                    child: Card(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Reject",
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
            ],)
          ],
        ),
      ),
    );
  }
}
