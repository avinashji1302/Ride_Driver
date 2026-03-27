import 'dart:async';

import 'package:app/config/colors/app_color.dart';
import 'package:app/config/common/snacbar/top_snacbar.dart';
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
                controller.vehicleTypeController = value!;
              },
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Vehicle Number",
              controller: controller.vehicleNumberController,
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Vehicle Model",
              controller: controller.vehicleModel,
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "RC Number",
              controller: controller.rcNumberController,
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Vehicle Color",
              controller: controller.vehicleColorController,
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: InputFieldWidget(
                    hint: "Vehicle Age",
                    controller: controller.vehicleAgeController,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InputFieldWidget(
                    hint: "Seating Capacity",
                    controller:controller.seatingCapacityController,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            InputFieldWidget(
              hint: "Owner Name",
              controller:controller.ownerNameController,
            ),

            const SizedBox(height: 10),

            InputFieldWidget(
              hint: "Owner Mobile",
              controller: controller.ownerMobileController,
            ),

            const SizedBox(height: 30),

            /// REGISTER BUTTON
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () async {
            //       final result = await controller.registerHere();

            //       print(("result : $result"));

            //       if (result.success) {
            //         debugPrint("result is : ${result.data}");

            //         AppSnackBar.show(context, message: result.message , backgroundColor: Colors.green);
            //          Navigator.of(context).push(
            //           MaterialPageRoute(builder: (context) => LoginScreen()),
            //         );
            //       }
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: AppColor.primaryYellow,
            //       padding: const EdgeInsets.symmetric(vertical: 14),
            //     ),
            //     child:controller.isLoading?CircularProgressIndicator() :const Text(
            //       "Register",
            //       style: TextStyle(color: AppColor.black),
            //     ),
            //   ),
            // ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isLoading
                    ? null
                    : () async {
                        final result = await controller.registerHere();

                        if (result.success) {
                          AppSnackBar.show(
                            context,
                            message: result.message,
                            backgroundColor: Colors.green,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        } else {
                          AppSnackBar.show(
                            context,
                            message: result.message,
                            backgroundColor: Colors.red,
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryYellow,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: controller.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.black,
                        ),
                      )
                    : const Text(
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
