import 'package:app/config/colors/app_color.dart';
import 'package:app/core/validator/validators.dart';
import 'package:app/screens/auth/login/view/varify_otp.dart';
import 'package:app/screens/auth/login/viewModel/login_provider.dart';
import 'package:app/screens/auth/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        leading: const BackButton(),
      ),
      body: Consumer<LoginProvider>(
        builder: (BuildContext context, controller, Widget? child) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                 key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Country code
                        SizedBox(
                          width: 100,
                          child: InputFieldWidget(
                            controller: controller.numberController,
                            hint: "+91",
                            validator: Validators.validateCountryCode,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            prefixIcon: const Icon(Icons.flag),
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Phone number
                        Expanded(
                          child: InputFieldWidget(
                             controller: controller.numberController,
                            hint: "Mobile Number",
                            validator: Validators.validatePhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(10),
                            ],
                            prefixIcon: const Icon(Icons.phone_outlined),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // GestureDetector(
                    //   onTap: () {

                    //   },
                    //   child: Text(
                    //     "Forget Password",
                    //     style: TextStyle(color: Colors.red),
                    //     textDirection: TextDirection.rtl,
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    /// Sign in button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        onPressed: () async {
                          final result = await controller.loginHandle();
                            debugPrint(":data is : ${result}");
                          if(result.success){
                           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VarifyOtp()));
                          }
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text("or"),
                        ),
                        Expanded(child: Divider(color: Colors.grey.shade300)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// Social buttons
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: const [
                    //     SocialButton(icon: Icons.mail),
                    //     SizedBox(width: 15),
                    //     SocialButton(icon: Icons.facebook),
                    //     SizedBox(width: 15),
                    //     SocialButton(icon: Icons.apple),
                    //   ],
                    // ),
                    const SizedBox(height: 20),

                    /// Footer
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => SignUpScreen(),
                          //   ),
                          // );
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: Colors.black),
                            children: [
                              TextSpan(text: "Did not have an account? "),
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  color: AppColor.primaryYellow,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
