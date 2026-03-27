import 'package:app/config/common/snacbar/top_snacbar.dart';
import 'package:app/screens/auth/login/view/login_screen.dart';
import 'package:app/screens/home/viewModel/home_provider.dart';
import 'package:app/screens/profile/view/update_profile.dart';
import 'package:app/screens/profile/view/upload_doc.dart';
import 'package:app/screens/profile/view_model/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:app/config/colors/app_color.dart';
import 'package:provider/provider.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  @override
  void initState() {
    super.initState();

    /// ⭐⭐⭐ CALL API WHEN SCREEN LOADS
    Future.microtask(() {
      context.read<LogoutProvider>().getProfile(); // ⭐ ADDED
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LogoutProvider>();
    final homeProvider = context.watch<HomeProvider>();

    final user = controller.userPrifile; // ⭐ ADDED

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// Top Profile Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppColor.primaryYellow,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      user?.driver?.profile ??
                          "https://randomuser.me/api/portraits/men/32.jpg", // ⭐ UPDATED
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    user?.driver?.firstName ?? "No Name", // ⭐ UPDATED
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "⭐ ${user?.driver?.rating ?? "0.0"} Rating", // ⭐ UPDATED
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Info Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildInfoTile(
                    icon: Icons.phone,
                    title: "Phone",
                    value:
                        "${user?.driver?.countryCode ?? ""} ${user?.driver?.mobile ?? ""}",
                  ),

                  _buildInfoTile(
                    icon: Icons.email,
                    title: "Email",
                    value: user?.driver?.email ?? "-",
                  ),

                  _buildInfoTile(
                    icon: Icons.location_city,
                    title: "City",
                    value: user?.driver?.city ?? "-",
                  ),

                  _buildInfoTile(
                    icon: Icons.home,
                    title: "Address",
                    value: user?.driver?.address ?? "-",
                  ),

                  _buildInfoTile(
                    icon: Icons.bloodtype,
                    title: "Blood Group",
                    value: user?.driver?.bloodGroup ?? "-",
                  ),

                  /// 🚗 VEHICLE DATA
                  _buildInfoTile(
                    icon: Icons.directions_car,
                    title: "Vehicle",
                    value:
                        "${user?.vehicle?.model ?? "-"} (${user?.vehicle?.type ?? ""})",
                  ),

                  _buildInfoTile(
                    icon: Icons.confirmation_number,
                    title: "Vehicle Number",
                    value: user?.vehicle?.number ?? "-",
                  ),

                  _buildInfoTile(
                    icon: Icons.color_lens,
                    title: "Color",
                    value: user?.vehicle?.color ?? "-",
                  ),

                  _buildInfoTile(
                    icon: Icons.approval,
                    title: "Registration Status",
                    value: user?.driver?.status ?? "-", // ⭐ UPDATED
                  ),

                  const SizedBox(height: 30),

                  /// ⭐⭐⭐ UPLOAD DOCUMENT BUTTON (ADD HERE)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            AppColor.primaryYellow, // or AppColor.primaryYellow
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => UploadDocsScreen(), // ⭐ your screen
                          ),
                        );
                      },
                      child: const Text(
                        "Upload Documents",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const UpdateProfileScreen(),
                              ),
                            );
                          },
                          child: const Text("Edit Profile"),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () async {
                            final result = await controller.logout();

                            if (result.success) {
                              homeProvider.tapBottemIndex = 0;
                            }

                            if (result.success) {
                              AppSnackBar.show(
                                context,
                                message: result.message,
                                backgroundColor: Colors.green,
                              );

                              homeProvider.isDriverAvailable = false;

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Info Tile Widget static Widget
_buildInfoTile({
  required IconData icon,
  required String title,
  required String value,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Icon(icon, color: AppColor.primaryYellow),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Stat Card Widget static Widget
_buildStatCard(String value, String label) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    ),
  );
}
