import 'dart:async';

import 'package:app/config/colors/app_color.dart';
import 'package:app/screens/auth/login/view/login_screen.dart';
import 'package:app/screens/auth/register/viewModel/register_provider.dart';
import 'package:app/screens/auth/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreenTwo extends StatelessWidget {
  RegisterScreenTwo({super.key});
  Set<String> selected = Set.from([]); // Set to hold selected items

  @override
  Widget build(BuildContext context) {
    final controller = context.read<RegisterProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Register – Step 2")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // InputFieldWidget(
            //   hint: "Vehicle Type",
            //   controller: TextEditingController(),
            // ),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryYellow),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColor.primaryYellow),
                ),
                hintText: "Choose Your Vehcile",
              ),
              items: ["auto", "bike"].map((val) {
                return DropdownMenuItem(
                  value: val,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ), // Add space between checkbox and text
                      Text(val), // Display item label
                    ],
                  ),
                );
              }).toList(),

              onChanged: (String? value) {
                controller.vehicleTypeController = value;
              },
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Vehicle Number",
              controller: TextEditingController(),
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Vehicle Model",
              controller: TextEditingController(),
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "RC Number",
              controller: TextEditingController(),
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Vehicle Color",
              controller: TextEditingController(),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                    hint: "Vehicle Age",
                    controller: TextEditingController(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                    hint: "Seating Capacity",
                    controller: TextEditingController(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            InputFieldWidget(
              hint: "Owner Name",
              controller: TextEditingController(),
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Owner Mobile",
              controller: TextEditingController(),
            ),

            const SizedBox(height: 30),

            /// REGISTER BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final result = await controller.registerHere();

                  print(("result : $result"));

                  if (result.success) {
                    debugPrint("result is : ${result.data}");
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryYellow,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(color: AppColor.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
