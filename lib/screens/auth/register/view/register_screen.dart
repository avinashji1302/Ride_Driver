import 'dart:io';
import 'package:app/config/colors/app_color.dart';
import 'package:app/config/time/scheduled_time.dart';
import 'package:app/screens/auth/register/view/register_screen_two.dart';
import 'package:app/screens/auth/register/viewModel/register_provider.dart';
import 'package:app/screens/auth/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class RegisterScreenOne extends StatelessWidget {
  const RegisterScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
      final controller = context.read<RegisterProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text("Register") , backgroundColor: Colors.transparent,centerTitle: true,),
      body: Consumer<RegisterProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [

                /// PROFILE IMAGE
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Camera"),
                              onTap: () {
                                Navigator.pop(context);
                                provider.pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.image),
                              title: const Text("Gallery"),
                              onTap: () {
                                Navigator.pop(context);
                                provider.pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: AppColor.lightyellow,
                    backgroundImage: provider.selectedImage != null
                        ? FileImage(File(provider.selectedImage!.path))
                        : null,
                    child: provider.selectedImage == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: InputFieldWidget(
                        hint: "First Name",
                        controller: controller.firstName,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputFieldWidget(
                        hint: "Last Name",
                        controller: controller.lastName,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                InputFieldWidget(
                  hint: "Email",
                  controller: controller.emailController,
                ),

                const SizedBox(height: 10),

                GestureDetector(
                 onTap: () async {
                        final scheduledTime = await pickDateTime(context);
                        if (scheduledTime == null) {
                          return;
                        }

                        print(scheduledTime);
                      },
                  child: InputFieldWidget(
                      prefixIcon: Icon(Icons.calendar_month),
                    hint: "DOB (YYYY-MM-DD)",
                    controller: TextEditingController(),
                  ),
                ),

                const SizedBox(height: 10),

                InputFieldWidget(
                
                  hint: "Blood Group",
                  controller: TextEditingController(),
                ),

                const SizedBox(height: 10),

                InputFieldWidget(
                  hint: "Mobile",
                  controller: controller.mobileController,
                ),

                const SizedBox(height: 10),

                InputFieldWidget(
                  hint: "Secondary Mobile",
                  controller: TextEditingController(),
                ),

                const SizedBox(height: 10),

                InputFieldWidget(
                  hint: "Address",
                  controller: TextEditingController(),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: InputFieldWidget(
                        hint: "City",
                        controller: TextEditingController(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InputFieldWidget(
                        hint: "State",
                        controller: TextEditingController(),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// NEXT BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>  RegisterScreenTwo(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryYellow,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text("Next" , style: TextStyle(color: AppColor.black),),
                  ),

                
                ),
                  SizedBox(height: 10,)
              ],
            ),
          );
        },
      ),
    );
  }
}
