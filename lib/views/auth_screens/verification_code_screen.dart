import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/constants_widgets.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  // 4 OTP controllers
  TextEditingController otp1 = TextEditingController();
  TextEditingController otp2 = TextEditingController();
  TextEditingController otp3 = TextEditingController();
  TextEditingController otp4 = TextEditingController();

  // 4 FocusNodes
  FocusNode focus1 = FocusNode();
  FocusNode focus2 = FocusNode();
  FocusNode focus3 = FocusNode();
  FocusNode focus4 = FocusNode();

  @override
  void dispose() {
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();

    focus1.dispose();
    focus2.dispose();
    focus3.dispose();
    focus4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow aligned to start
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 5.w),
            child: GestureDetector(
              onTap: () {
                Get.back(); // back to previous screen
              },
              child: Image.asset(
                "assets/icon/arrow-narrow-left.png",
                height: 4.h,
                width: 3.8.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 5.h),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.75.w), // 35 px approx => 8.75% width
            child: customText(
              text: "Verification Code",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: otpscreenblue,
              fontFamily: "Inter",
            ),
          ),

          SizedBox(height: 1.h),

          // Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.75.w),
            child: customText(
              text: "We have sent the verification",
              fontSize: 15.sp,
              color: otpscreenblack1,
              fontFamily: "Poppins",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.75.w),
            child: customText(
              text: "code to your phone number",
              fontSize: 15.sp,
              color: otpscreenblack1,
              fontFamily: "Poppins",
            ),
          ),

          SizedBox(height: 4.h),

          // OTP fields row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              otpBox(otp1, focus1, focus2),
              otpBox(otp2, focus2, focus3),
              otpBox(otp3, focus3, focus4),
              otpBox(otp4, focus4, null),
            ],
          ),

          SizedBox(height: 5.h),

          // Continue button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.25.w), // 25 px approx => 6.25% width
            child: CustomButton(

              borderRadius: BorderRadius.circular(40),
              text: "Confirm",
              btnColor: darkColor,
              fontWeight: FontWeight.w600,
              height: 7.h,
              width: 92.w,
              fontFamily: "Poppins",
              onTap: () {
                Get.toNamed('/SucessScreen');// TODO: Add GetX navigation here
              },
            ),
          ),
        ],
      ),
    );
  }

  // OTP box widget with automatic focus change
  Widget otpBox(TextEditingController controller, FocusNode currentFocus, FocusNode? nextFocus) {
    return Container(
      width: 14.w,
      height: 6.3.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Color(0xFFDDDDDD),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.length == 1) {
            if (nextFocus != null) {
              FocusScope.of(context).requestFocus(nextFocus);
            } else {
              currentFocus.unfocus(); // last field
            }
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus(); // backspace handling
          }
        },
      ),
    );
  }
}
