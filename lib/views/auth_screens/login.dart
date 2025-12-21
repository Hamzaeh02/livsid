import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  bool _obscurePassword = true; // 👁️ toggle state

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
            children: [
              // Logo
              Positioned(
                top: 13.h,
                left: 10.w,
                child: Image.asset(
                  "assets/icon/logo.png",
                  height: 17.h,
                  width: 17.h,
                  fit: BoxFit.cover,
                ),
              ),
        
              // App Name
              Positioned(
                top: 19.h,
                left: 43.w,
                child: customText(
                  text: "LivSD",
                  fontSize: 30.sp,
                  color: whiteColors,
                  fontFamily: "SF Pro",
                ),
              ),
        
              // Subtitle
              Positioned(
                top: 33.h,
                left: 19.w,
                child: customText(
                  text: "Get started now",
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: whiteColors,
                  fontFamily: "SF Pro",
                ),
              ),
        
              // TextField Container
            Positioned(
              top: 40.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                height: 12.8.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: whiteColors,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                   // Container height adjusts to content
                  children: [
                    // EMAIL
                    Row(

                      children: [
                        Image.asset(
                          "assets/icon/mail.png",
                          height: 3.h,
                          width: 5.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              color: myColor,
                              fontSize: 15.sp,
                            ),
                           // vertical center
                            decoration: InputDecoration(
                              hintText: "Loisbecket@gmail.com",
                              hintStyle: TextStyle(
                                color: myColor,
                                fontFamily: "inter",
                                fontSize: 14.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(bottom:2), // hint text padding
                            ),
                          ),
                        ),
                      ],
                    ),
                    // spacing between fields

                    // PASSWORD
                    Row(

                      children: [
                        Image.asset(
                          "assets/icon/locks.png",
                          height: 3.h,
                          width: 5.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: TextField(
                            obscureText: _obscurePassword,
                            style: TextStyle(
                              color: myColor,
                              fontSize: 15.sp,
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: "*******",
                              hintStyle: TextStyle(
                                color: darkGrey,
                                fontFamily: "inter",
                                fontSize: 15.sp,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 0.2.h),
                              suffixIcon: IconButton(
                                icon: Image.asset(
                                  "assets/icon/eyelogo.png",
                                  height: 2.h,
                                  width: 4.w,
                                  fit: BoxFit.contain,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


        
              // Signup prompt
              Positioned(
                top: 53.h,
                left: 24.w,
                child: Row(
                  children: [
                    customText(
                      text: "Don’t have an account?",
                      fontSize: 14.sp,
                      color: whiteColors,
                      fontFamily: "SF Pro",
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/Signup');
                      },
                      child: customText(
                        text: " Sign Up",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: whiteColors,
                        fontFamily: "inter",
                      ),
                    ),
                  ],
                ),
              ),
        
              // Log In Button
              Positioned(
                top: 56.h,
                left: 10.w,
                child: CustomButton(
                  borderRadius: BorderRadius.circular(10),
                  text: "Log In",
                  btnColor: darkColor,
                  fontWeight: FontWeight.w600,
                  height: 5.h,
                  width: 80.w,
                  fontFamily: "Poppins",
                ),
              ),
        
              // Forgot password
              Positioned(
                top: 62.h,
                left: 33.w,
                child: customText(
                  text: "Forgot Your Password ?",
                  fontSize: 14.sp,
                  color: whiteColors,
                  fontFamily: "SF Pro",
                ),
              ),
        
              // Or login with divider
              Positioned(
                top: 66.h,
                left: 13.w,
                right: 13.w,
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.white, thickness: 1.5),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: customText(
                        text: "Or login with",
                        fontSize: 14.sp,
                        color: whiteColors,
                        fontFamily: "SF Pro",
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white, thickness: 1.5),
                    ),
                  ],
                ),
              ),
        
              // Bottom Vector Image
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  "assets/icon/Vector.png",
                  alignment: Alignment.bottomCenter,
                ),
              ),
        
              // Social Login Buttons
              Positioned(
                left: 9.w,
                top: 68.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    socialButton("assets/icon/google.png"),
                    SizedBox(width: 3.w),
                    socialButton("assets/icon/facebook.png"),
                    SizedBox(width: 3.w),
                    socialButton("assets/icon/apple.png"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget socialButton(String assetPath) {
    return Center(
      child: Image.asset(
        assetPath,
        height: 11.h,
        width: 11.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
