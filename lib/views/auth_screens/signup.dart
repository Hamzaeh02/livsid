import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              lightblue,
              darkblue,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Top-left back button
            Stack(
              children: [
                // Top main image
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/icon/toplogo.png",
                    alignment: Alignment.topCenter,
                    fit: BoxFit.cover,
                  ),
                ),
                // Back button upar image ke upar
                Positioned(
                  top: 5.h,
                  left: 5.w,
                  child: GestureDetector(
                    onTap: () {
                      Get.back(); // GetX back
                    },
                    child: Image.asset(
                      "assets/icon/arrow-narrow-left.png",
                      height: 4.h,
                      width: 4.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),

            Positioned(
              top: 20.h,
              left: 8.w,
              right: 8.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: "Register",
                    fontSize: 25.sp,
                    color: whiteColors,
                    fontWeight: FontWeight.w600,
                    fontFamily: "SF Pro",
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "Create an account to continue!",
                    fontSize: 14.sp,
                    color: whiteColors,
                    fontFamily: "SF Pro",
                  ),
                  SizedBox(height: 2.h),

                  // TextFields
                  buildTextField("First Name"),
                  buildTextField("Last Name"),
                  buildTextField("Email"),
                  buildTextFieldWithIcon("Birthday", "assets/icon/calendar-due.png"),
                  buildTextField("Phone Number"),
                  buildPasswordField("Password", "assets/icon/eye-off.png"),

                  SizedBox(height: 2.h),

                  // Sign Up Button
                  CustomButton(
                    borderRadius: BorderRadius.circular(10),
                    text: "Sign Up",
                    btnColor: darkColor,
                    fontWeight: FontWeight.w600,
                    height: 5.h,
                    width: 90.w,
                    onTap: () {
                      Get.toNamed('/Otp'); // Named route
                    },
                  ),
                  SizedBox(height: 1.h),

                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customText(
                        text: "Already have an account?",
                        fontSize: 14.sp,
                        color: whiteColors,
                        fontFamily: "SF Pro",
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed('/Login');
                        },
                        child: customText(
                          text: " Log in",
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: whiteColors,
                          fontFamily: "inter",
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

  // Normal TextField
  Widget buildTextField(String hint) {
    return Container(
      height: 5.2.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: whiteColors,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: TextField(
        style: TextStyle(color: myColor, fontSize: 15.sp),
        
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.only(bottom: 1.h),
          hintStyle: TextStyle(
            color: myColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: "inter",
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // TextField with right-side icon
  Widget buildTextFieldWithIcon(String hint, String iconPath) {
    return Container(
      height: 5.2.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: whiteColors,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: myColor, fontSize: 15.sp),

              decoration: InputDecoration(
                hintText: hint,
                contentPadding: EdgeInsets.only(bottom: 1.h),
                hintStyle: TextStyle(

                  color: myColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "inter",
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Image.asset(
            iconPath,
            height: 2.5.h,
            width: 5.w,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }

  // Password TextField with eye icon
  Widget buildPasswordField(String hint, String iconPath) {
    bool _obscurePassword = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: 5.2.h,
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          margin: EdgeInsets.only(bottom: 2.h),
          decoration: BoxDecoration(
            color: whiteColors,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 1),
                blurRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: myColor, fontSize: 15.sp),
                  
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: hint,
                    contentPadding: EdgeInsets.only(bottom: 1.h),
                    hintStyle: TextStyle(
                      color: myColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: "inter",
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
                child: Image.asset(
                  iconPath,
                  height: 2.5.h,
                  width: 5.w,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
