import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/utils/helper_functions.dart'; // Ensure this is imported for validation
import 'package:livsd/widgets/util.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  final AuthController authController = Get.put(AuthController());

  // Added the Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: 100.w,
        // Changed to constraints to prevent overflow during validation errors
        constraints: BoxConstraints(minHeight: 100.h),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightblue, darkblue],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Form Key applied here
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

                      // Text Fields with added validation
                      buildTextField("Full Name", authController.signupNameField, isName: true),
                      buildTextField("Email", authController.signupEmailField, isEmail: true),
                      buildTextField("Phone Number", authController.signupPhoneField, isPhone: true),

                      // Password Field with added validation
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
                          // Standard validation check
                          if (_formKey.currentState!.validate()) {
                            if (authController.signupNameField.text.isNotEmpty &&
                                authController.signupEmailField.text.isNotEmpty &&
                                authController.signupPhoneField.text.isNotEmpty &&
                                authController.signupPasswordField.text.isNotEmpty) {
                              await authController.signUp();
                            } else {
                              Utils.showToast("Complete All The Fields", true);
                            }
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
      ),
    );
  }

// Updated buildTextField with reduced size
  Widget buildTextField(String hint, TextEditingController controller, {bool isEmail = false, bool isPhone = false, bool isName = false}) {
    return Container(
      // Reduced vertical padding
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      margin: EdgeInsets.only(bottom: 1.5.h), // Reduced bottom margin
      decoration: BoxDecoration(
        color: whiteColors,
        borderRadius: BorderRadius.circular(10), // Slightly sharper corners
        border: Border.all(color: Colors.blue, width: 0.8), // Thinner border
      ),
      child: TextFormField(
        controller: controller,
        // Reduced font size from 15.sp to 13.sp
        style: TextStyle(color: myColor, fontSize: 12.sp),
        validator: (value) {
          if (value == null || value.isEmpty) return "Field required";
          if (isEmail) return HelperFunction.emailValidate(value);
          return null;
        },
        decoration: InputDecoration(
          hintText: hint,
          // Reduced hint font size
          hintStyle: TextStyle(color: myColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          isDense: true,
          // Tighter internal padding
          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
        ),
      ),
    );
  }

  // Updated _buildPasswordField with reduced size
  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      margin: EdgeInsets.only(bottom: 1.5.h),
      decoration: BoxDecoration(
        color: whiteColors,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 0.8),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !authController.isPasswordVisible.value,
        style: TextStyle(color: myColor, fontSize: 12.sp),
        validator: (value) => HelperFunction.passwordValidate(value!),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: myColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(vertical: 1.h),
          // Added constraints to keep the icon from stretching the field
          suffixIconConstraints: BoxConstraints(minHeight: 3.h, minWidth: 3.w),
          suffixIcon: GestureDetector(
            onTap: () => authController.togglePasswordVisibility(),
            child: Icon(
              authController.isPasswordVisible.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.grey,
              size: 16.sp, // Slightly smaller icon
            ),
          ),
        ),
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
            top: 5.5.h, left: 5.w,
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