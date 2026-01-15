import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
// Apna custom text widget ka file import zaroor karein
// import '../../widgets/custom_text.dart';

void successDialog(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    VoidCallback onTap,
    ) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xFFF8FBFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ✅ Top Icon
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 50.sp,
                ),
              ),
              SizedBox(height: 3.h),

              // ✅ Custom Title Text
              customText(
                text: title,
                textAlign: TextAlign.center,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: darkblue,
              ),
              SizedBox(height: 1.5.h),

              // ✅ Custom Message Text
              customText(
                text: message,
                textAlign: TextAlign.center,
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
              SizedBox(height: 4.h),

              // ✅ Premium Action Button
              GestureDetector(
                onTap: () {
                  Get.back();
                  onTap();
                },
                child: Container(
                  height: 6.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00BBFF), Color(0xFF26AFE9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: customText(
                      text: buttonText,
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}