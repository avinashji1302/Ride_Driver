import 'package:app/screens/profile/view_model/logout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final city = TextEditingController();
  final address = TextEditingController();
  final state = TextEditingController();
  final bloodGroup = TextEditingController();

  /// Vehicle
  final vehicleType = TextEditingController();
  final vehicleNumber = TextEditingController();
  final vehicleModel = TextEditingController();
  final rcNumber = TextEditingController();
  final color = TextEditingController();
  final seatingCapacity = TextEditingController();

  @override
  void initState() {
    super.initState();

    /// ⭐ PREFILL DATA
    final data = context.read<LogoutProvider>().userPrifile;

    firstName.text = data?.driver?.firstName ?? "";
    lastName.text = data?.driver?.lastName ?? "";
    email.text = data?.driver?.email ?? "";
    city.text = data?.driver?.city ?? "";
    address.text = data?.driver?.address ?? "";
    state.text = data?.driver?.state ?? "";
    bloodGroup.text = data?.driver?.bloodGroup ?? "";

    vehicleType.text = data?.vehicle?.type ?? "";
    vehicleNumber.text = data?.vehicle?.number ?? "";
    vehicleModel.text = data?.vehicle?.model ?? "";
    rcNumber.text = data?.vehicle?.rcNumber ?? "";
    color.text = data?.vehicle?.color ?? "";
    seatingCapacity.text = data?.vehicle?.seatingCapacity ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LogoutProvider>();
    final isPending =
        provider.userPrifile?.driver?.registrationStatus == "pending";

    return Scaffold(
      appBar: AppBar(title: const Text("Update Profile")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _field(firstName, "First Name", enabled: isPending),
                _field(lastName, "Last Name", enabled: isPending),
                _field(email, "Email"),
                _field(city, "City"),
                _field(address, "Address"),
                _field(state, "State"),
                _field(bloodGroup, "Blood Group"),

                const SizedBox(height: 20),

                /// 🚗 VEHICLE
                _field(vehicleType, "Vehicle Type"),
                _field(vehicleNumber, "Vehicle Number"),
                _field(vehicleModel, "Vehicle Model"),
                _field(rcNumber, "RC Number"),
                _field(color, "Color"),
                _field(seatingCapacity, "Seating Capacity"),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    if (!_formKey.currentState!.validate()) return;

                    //                     const editableBeforeApproval = [
                    //   'firstName',
                    //   'lastName',
                    //   'dob',
                    //   'address',
                    //   'city',
                    //   'languages',
                    //   'profile',
                    //   'secondaryMobile',
                    //   'bloodGroup'
                    // ]

                    // const editableAfterApproval = [
                    //   'city',
                    //   'languages',
                    //   'profile',
                    //   'secondaryMobile',
                    //   'bloodGroup'
                    // ]

                    if (provider.userPrifile?.driver?.status == "active") {
                      final body = {
                        "city": city.text,
                        "languages": lastName.text,
                        'profile': "",
                        'secondaryMobile': "2323232",
                        'bloodGroup': "A",
                      };

                      final res = await provider.updateProfile(body); // ⭐ API

                      if (res.success) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(res.message)));
                        Navigator.pop(context);
                      }
                    } else {
                      final body = {
                        "firstName": firstName.text,
                        "lastName": lastName.text,
                        "email": email.text,
                        "city": city.text,
                        "address": address.text,
                        "state": state.text,
                        "bloodGroup": bloodGroup.text,
                        "languages": ["Hindi", "English"],

                        "vehicleType": vehicleType.text,
                        "vehicleNumber": vehicleNumber.text,
                        "vehicleModel": vehicleModel.text,
                        "rcNumber": rcNumber.text,
                        "driverIsOwner": true,
                        "vehicleAge": 2,
                        "isSafetyTested": true,
                        "color": color.text,
                        "seatingCapacity":
                            int.tryParse(seatingCapacity.text) ?? 4,
                      };

                      final res = await provider.updateProfile(body); // ⭐ API

                      if (res.success) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(res.message)));
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: provider.isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Update Profile"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        enabled: enabled,
        decoration: InputDecoration(labelText: label),
        validator: (v) => v!.isEmpty ? "Required" : null,
      ),
    );
  }
}
