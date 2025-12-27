import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/auth_controller.dart';

class VerificationCodeScreen extends StatelessWidget {
  VerificationCodeScreen({super.key});

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColors,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back Arrow
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  "assets/icon/arrow-narrow-left.png",
                  height: 4.h,
                  width: 3.8.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: 5.h),

            // Header Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.75.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customText(
                    text: "Verification Code",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: otpscreenblue,
                  ),
                  SizedBox(height: 1.h),
                  customText(
                    text: "We have sent the verification\ncode to your phone number",
                    fontSize: 15.sp,
                    color: otpscreenblack1,
                  ),
                ],
              ),
            ),

            SizedBox(height: 6.h),

            // OTP TEXTFIELD
            Center(
              child: OtpTextField(
                numberOfFields: 6,
                borderWidth: 1.5,
                enabledBorderColor: const Color(0xFFDDDDDD),
                focusedBorderColor: darkblue,
                borderRadius: BorderRadius.circular(10),
                // Height yahan se badhayein
                fieldWidth: 11.5.w, // Thoda width bhi badhaya taaki proportion sahi rahe
                fieldHeight: 10.h, // Isay 8.h se badha kar 10.h ya 12.h kar dein
                filled: true,
                fillColor: Colors.white,
                showFieldAsBox: true,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                textStyle: TextStyle(
                  fontSize: 18.sp, // Height ke saath font size bhi thoda bada karein
                  fontWeight: FontWeight.w600,
                  height: 1.5, // Text ko vertical center alignment dene ke liye
                ),
                // Padding ko adjust karein taaki text box ke beech mein rahe
                contentPadding: EdgeInsets.symmetric(vertical: 1.5.h),
                mainAxisAlignment: MainAxisAlignment.center,
                margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                onSubmit: (String verificationCode) {
                  controller.otp.value = verificationCode;
                },
              ),
            ),

            SizedBox(height: 3.h),

            // RESEND OTP SECTION
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customText(
                    text: "Didn't receive the code? ",
                    fontSize: 14.sp,
                    color: otpscreenblack1,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Aap yahan controller.resendOtp() call kar sakte hain
                      Get.snackbar("Success", "OTP Resent Successfully");
                    },
                    child: customText(
                      text: "Resend",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: otpscreenblue,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 6.h),

            // CONFIRM BUTTON - Isme logic update ki gayi hai
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: CustomButton(
                borderRadius: BorderRadius.circular(40),
                text: "Confirm",
                btnColor: darkColor,
                fontWeight: FontWeight.w600,
                height: 7.h,
                width: 92.w,
                onTap: () {
                  // Pehle check karein ke OTP khali to nahi
                  if (controller.otp.value.length == 6) {
                    // Controller wala function call karein jo "VERIFY_EMAIL" bhej raha hai
                    controller.verifyOtp(context);
                  } else {
                    Get.snackbar(
                      "Required",
                      "Please enter complete 6-digit code",
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}