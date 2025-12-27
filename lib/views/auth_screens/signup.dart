import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/widgets/util.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: 100.w,
        height: 100.h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightblue, darkblue],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _topLogoSection(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.h),
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

                    // Text Fields
                    buildTextField("Full Name", authController.signupNameField),
                    buildTextField("Email", authController.signupEmailField),
                    buildTextField("Phone Number", authController.signupPhoneField),

                    // Password Field
                    _buildPasswordField("Password", authController.signupPasswordField),

                    SizedBox(height: 2.h),

                    CustomButton(
                      borderRadius: BorderRadius.circular(10),
                      text: "Sign Up",
                      btnColor: darkColor,
                      fontWeight: FontWeight.w600,
                      height: 5.h,
                      width: 90.w,
                      onTap: () async {
                        // Bracket aur logic fixed here
                        if (authController.signupNameField.text.isNotEmpty &&
                            authController.signupEmailField.text.isNotEmpty &&
                            authController.signupPhoneField.text.isNotEmpty &&
                            authController.signupPasswordField.text.isNotEmpty) {
                          await authController.signUp();
                        } else {
                          Utils.showToast("Complete All The Fields", true);
                        }
                      },
                    ),

                    SizedBox(height: 2.h),
                    _bottomLoginLink(),
                    SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helpers (Design remains same) ---

  Widget buildTextField(String hint, TextEditingController controller) {
    return Container(
      height: 5.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.9.h),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: whiteColors,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: myColor, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: myColor, fontSize: 15.sp, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return Obx(() => Container(
      height: 5.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.9.h),
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: whiteColors,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: !authController.isPasswordVisible.value,
              style: TextStyle(color: myColor, fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: myColor, fontSize: 15.sp, fontWeight: FontWeight.w500),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 1.h),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => authController.togglePasswordVisibility(),
            child: Icon(
              authController.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ));
  }

  Widget _topLogoSection() {
    return SizedBox(
      height: 20.h,
      child: Stack(
        children: [
          Image.asset("assets/icon/toplogo.png", width: 100.w, fit: BoxFit.cover),
          Positioned(
            top: 5.h, left: 5.w,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset("assets/icon/arrow-narrow-left.png", height: 4.h),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customText(text: "Already have an account?", fontSize: 14.sp, color: whiteColors),
        GestureDetector(
          onTap: () => Get.toNamed('/Login'),
          child: customText(text: " Log in", fontSize: 15.sp, fontWeight: FontWeight.bold, color: whiteColors),
        ),
      ],
    );
  }
}