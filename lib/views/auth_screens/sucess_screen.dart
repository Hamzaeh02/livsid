import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart' show customText;

class SucessScreen extends StatelessWidget {
  const SucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.only(top: 25.h),

        child: Center(
          child:
          Column(
            children: [
              Image.asset(
                'assets/icon/sucesslogo.png', // place your clip art here
                fit: BoxFit.contain,
              ),
              SizedBox(height: 1.h,),
              customText(
                text: "Success!",
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: otpscreenblack,
                fontFamily: "Inter",
                 // line height 100%
                letterSpacing: 0.0,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0.2.h,),
              customText(
                text: "Congratulations! You have been",
                fontSize: 18.sp,

                color: otpscreenblack1,
                fontFamily: "Poppins",
               // line height 100%
                letterSpacing: 0.0,
                textAlign: TextAlign.center,
              ),
              customText(
                text: "successfully authenticated",
                fontSize: 18.sp,

                color: otpscreenblack1,
                fontFamily: "Poppins",
                // line height 100%
                letterSpacing: 0.0,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h,),
              CustomButton(

                borderRadius: BorderRadius.circular(40),
                text: "Continue",
                btnColor: darkColor,
                btnTextColor: whiteColors,

                fontWeight: FontWeight.bold,
                height: 7.h,
                width: 92.w,
                fontFamily: "Poppins",
                onTap: () {
                  Get.toNamed('/MainScreen');// TODO: Add GetX navigation here
                },
              ),

            ],

          ),
        ),
      ),
    );
  }
}
