import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/controllers/auth_controller.dart';
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
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Logo
              Positioned(
                top: 13.h,
                left: 17.w,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/icon/logo.png",
                      height: 14.h,
                      width: 14.h,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),

              // App Name
              Positioned(
                top: 16.h,
                left: 43.w,
                child: customText(
                  text: "LivSD",
                  fontSize: 30.sp,
                  color: whiteColors,
                  fontFamily: "SF Pro",
                  fontWeight: FontWeight.w600,
                ),
              ),

              // Subtitle
              Positioned(
                top: 30.h,
                child: customText(
                  text: "Get started now",
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: whiteColors,
                  fontFamily: "SF Pro",
                ),
              ),

              /// --- OPTIMIZED INPUT GROUP ---
              /// Dono containers ko ek hi Column mein rakha hai taake divider gap na aaye
              Positioned(
                top: 37.2.h, // Aapki exact position
                left: 11.w,
                right: 11.w,
                child: Column(
                  children: [
                    // Email Container
                    Container(
                      padding: EdgeInsets.only(bottom: 0.6.h, left: 2.8.w, right: 2.8.w),
                      decoration: const BoxDecoration(
                        color: whiteColors,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 1.w),
                          Image.asset("assets/icon/mail.png", height: 3.h, width: 4.5.w, fit: BoxFit.contain),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: TextField(
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

                    // Divider - Jo pehle alag Positioned tha, ab yahan hai alignment ke liye
                    Divider(color: Colors.grey.withOpacity(0.3), thickness: 0.15.h, height: 0),

                    // Password Container
                    Container(
                      padding: EdgeInsets.only(bottom: 0.4.h, left: 3.w, right: 3.w),
                      decoration: const BoxDecoration(
                        color: whiteColors,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 1.w),
                          Image.asset("assets/icon/locks.png", height: 2.8.h, width: 5.w, fit: BoxFit.contain),
                          SizedBox(width: 3.w),
                          Expanded(
                            child: TextField(
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

              // Signup prompt
              Positioned(
                top: 49.h,
                child: Row(
                  children: [
                    customText(text: "Don’t have an account?", fontSize: 14.sp, color: whiteColors, fontFamily: "SF Pro"),
                    GestureDetector(
                      onTap: () => Get.toNamed('/Signup'),
                      child: customText(text: " Sign Up", fontSize: 14.sp, fontWeight: FontWeight.w600, color: whiteColors, fontFamily: "inter"),
                    ),
                  ],
                ),
              ),

              // Log In Button
              Positioned(
                top: 52.5.h,
                child: CustomButton(
                  borderRadius: BorderRadius.circular(10),
                  text: "Log In",
                  btnColor: darkColor,
                  fontWeight: FontWeight.w500,
                  height: 5.h,
                  width: 80.w,
                  fontFamily: "Poppins",
                  onTap: () async {
                    // Logic Fix: Dono fields check karein ke empty na hon
                    if (authController.loginEmailField.text.isNotEmpty &&
                        authController.loginPasswordField.text.isNotEmpty) {
print(authController.loginEmailField.text);
print(authController.loginPasswordField.text);
                      await authController.login();

                    } else {
                      // Sirf tabhi toast dikhayein jab fields khali hon
                      Utils.showToast("Please fill in all fields", true);
                    }
                  },
                ),
              ),

              // Forgot password
              // Forgot password
              Positioned(
                top: 58.5.h,
                child: GestureDetector(
                  onTap: () {
                    // Aapke route ka jo bhi naam ho ('/ForgotPassword' ya jo aapne set kiya ho)
                    Get.toNamed('/Otp');
                  },
                  child: customText(
                    text: "Forgot Your Password ?",
                    fontSize: 14.sp,
                    color: whiteColors,
                    fontFamily: "SF Pro",
                  ),
                ),
              ),

              // Or login with divider
              Positioned(
                top: 63.h,
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

              // Social Login Buttons
              Positioned(
                top: 65.h,
                child: Row(
                  children: [
                    socialButton("assets/icon/google.png"),
                    SizedBox(width: 3.w),
                    socialButton("assets/icon/facebook.png"),
                    SizedBox(width: 3.w),
                    socialButton("assets/icon/apple.png"),
                  ],
                ),
              ),

              // Bottom Vector Image
              Positioned(
                bottom: 0,
                child: Image.asset(
                  "assets/icon/Vector.png",
                  width: 100.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialButton(String assetPath) {
    return Image.asset(assetPath, height: 11.h, width: 11.h, fit: BoxFit.contain);
  }
}