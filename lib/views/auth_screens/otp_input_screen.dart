import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/constants/color_constants.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart' show CustomButton;
import '../../constants/constants_widgets.dart';

class OtpInputScreen extends StatelessWidget {
  const OtpInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60,horizontal: 100),
          child: Container(
          height: 20.h, // adjust height
          width: 20.h,  // keep square
          decoration: BoxDecoration(
            // optional border for styling
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            'assets/icon/Image.png', // place your clip art here
            fit: BoxFit.contain,
          ),
                ),
        ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: customText(
              text: "Human Verification",
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: otpscreenblack,
              fontFamily: "Inter",
            ),
          ),
          SizedBox(height: 1.h,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: customText(
              text: "Enter email or phone number to ",
              fontSize: 15.sp,

              color: otpscreenblack1,
              fontFamily: "Poppins",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: customText(
              text: "send one time password ",
              fontSize: 15.sp,

              color:otpscreenblack1,
              fontFamily: "Poppins",
            ),
          ),
          SizedBox(height: 2.h,),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // border color black
                  width: 1.5,          // border thickness
                ),
                borderRadius: BorderRadius.circular(12), // rounded corners
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'you@gmail.com', // hint text
                        border: InputBorder.none,     // Container ke border ka use ho
                      ),
                    ),
                  ),
                  SizedBox(width: 3.w), // TextField aur image ke beech gap
                  Image.asset(
                    "assets/icon/Edit icon.png",
                    height: 2.5.h,
                    width: 5.w,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 3.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: CustomButton(
              borderRadius: BorderRadius.circular(25),
              text: "Continue",
              btnColor: darkColor,
              fontWeight: FontWeight.w600,
              height: 6.h,
              width: 90.w,
              fontFamily: "Poppins",
              onTap: () {
                Get.toNamed('/Verification'); // yaha apni next screen ka widget name do
              },
            ),
          ),





        ],
      ),
    );
  }
}
