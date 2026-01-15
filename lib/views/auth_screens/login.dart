import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/controllers/auth_controller.dart';
import 'package:livsd/utils/helper_functions.dart';
import 'package:livsd/widgets/util.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: 100.w,
            height: 100.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [lightblue, darkblue],
              ),
            ),
            child: Column(
              children: [
                // Logo and App Name Row (Replacing Positioned top 13.h and 16.h)
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.only(left: 17.w),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // App Name
                      customText(
                        text: "LivSD",
                        fontSize: 30.sp,
                        color: whiteColors,
                        fontFamily: "SF Pro",
                        fontWeight: FontWeight.w600,
                      ),

                      // Positioned Logo
                      Positioned(
                        right: 32.w, // adjust as needed
                        top: -3.h,
                        child: Image.asset(
                          "assets/icon/logo.png",
                          height: 14.h,
                          width: 14.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),


                // Subtitle (Replacing Positioned top 30.h)
                SizedBox(height: 3.h),
                customText(
                  text: "Get started now",
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: whiteColors,
                  fontFamily: "SF Pro",
                ),

                SizedBox(height: 2.h),

                /// --- INPUT GROUP ---
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 0.6.h, left: 2.8.w, right: 2.8.w),
                        decoration: const BoxDecoration(
                          color: whiteColors,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(13),
                            topRight: Radius.circular(13),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 1.w),
                            Image.asset("assets/icon/mail.png", height: 3.h, width: 4.5.w, fit: BoxFit.contain),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: TextFormField(
                                validator: (value) => HelperFunction.emailValidate(value!),
                                controller: authController.loginEmailField,
                                style: TextStyle(color: myColor, fontSize: 14.sp),
                                decoration: InputDecoration(
                                  hintText: "Loisbecket@gmail.com",
                                  hintStyle: TextStyle(color: myColor, fontSize: 13.sp),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 1.h),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.grey.withOpacity(0.3), thickness: 0.15.h, height: 0),
                      Container(
                        padding: EdgeInsets.only(bottom: 0.4.h, left: 3.w, right: 3.w),
                        decoration: const BoxDecoration(
                          color: whiteColors,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(13),
                            bottomRight: Radius.circular(13),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 1.w),
                            Image.asset("assets/icon/locks.png", height: 2.8.h, width: 5.w, fit: BoxFit.contain),
                            SizedBox(width: 3.w),
                            Expanded(
                              child: TextFormField(
                                validator: (value) => HelperFunction.passwordValidate(value!),
                                controller: authController.loginPasswordField,
                                obscureText: _obscurePassword,
                                style: TextStyle(color: myColor, fontSize: 14.sp),
                                decoration: InputDecoration(
                                  hintText: "******",
                                  hintStyle: TextStyle(color: myColor, fontSize: 13.sp),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: 1.1.h),
                                  suffixIconConstraints: BoxConstraints(minHeight: 2.h, minWidth: 2.w),
                                  suffixIcon: GestureDetector(
                                    onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                                    child: Icon(
                                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.grey,
                                      size: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Signup prompt
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(text: "Don’t have an account?", fontSize: 14.sp, color: whiteColors, fontFamily: "SF Pro"),
                    GestureDetector(
                      onTap: () => Get.toNamed('/Signup'),
                      child: customText(text: " Sign Up", fontSize: 14.sp, fontWeight: FontWeight.w600, color: whiteColors, fontFamily: "inter"),
                    ),
                  ],
                ),

                SizedBox(height: 1.5.h),

                // Log In Button
                CustomButton(
                  borderRadius: BorderRadius.circular(10),
                  text: "Log In",
                  btnColor: darkColor,
                  fontWeight: FontWeight.w500,
                  height: 5.h,
                  width: 80.w,
                  fontFamily: "Poppins",
                  onTap: () async {
                    if(_formKey.currentState!.validate()){
                      if (authController.loginEmailField.text.isNotEmpty &&
                          authController.loginPasswordField.text.isNotEmpty) {
                        await authController.login();
                      } else {
                        Utils.showToast("Please fill in all fields", true);
                      }
                    }
                  },
                ),

                SizedBox(height: 1.5.h),

                // Forgot password
                GestureDetector(
                  onTap: () => Get.toNamed('/Otp'),
                  child: customText(
                    text: "Forgot Your Password ?",
                    fontSize: 14.sp,
                    color: whiteColors,
                    fontFamily: "SF Pro",
                  ),
                ),

                SizedBox(height: 2.h),

                // Or login with divider
                SizedBox(
                  width: 76.w,
                  child: Row(
                    children: [
                      const Expanded(child: Divider(color: whiteColors, thickness: 1.5)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: customText(text: "Or login with", fontSize: 14.sp, color: whiteColors, fontFamily: "SF Pro"),
                      ),
                      const Expanded(child: Divider(color: whiteColors, thickness: 1.5)),
                    ],
                  ),
                ),

                SizedBox(height: 2.h),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    socialButton("assets/icon/google.png"),
                    SizedBox(width: 3.w),
                    socialButton("assets/icon/facebook.png"),
                    SizedBox(width: 3.w),
                    socialButton("assets/icon/apple.png"),
                  ],
                ),

                const Expanded(child: SizedBox()), // Push the vector to the bottom

                // Bottom Vector Image
                Image.asset(
                  "assets/icon/Vector.png",
                  width: 100.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget socialButton(String assetPath) {
    return Image.asset(assetPath, height: 11.h, width: 11.h, fit: BoxFit.contain);
  }
}