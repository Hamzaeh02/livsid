import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Utils {
  // ✅ Premium Gradient Toast
  static void showToast(String message, bool isError) {
    Get.closeAllSnackbars();
    Get.rawSnackbar(
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w500),
      ),
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(15),
      borderRadius: 15,
      backgroundGradient: LinearGradient(
        colors: isError
            ? [Color(0xFFE52D27), Color(0xFFB31217)] // Professional Red
            : [Color(0xFF2193B0), Color(0xFF6DD5ED)], // Professional Blue
      ),
      icon: Icon(isError ? Icons.report_gmailerrorred : Icons.check_circle_outline, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }

  // ✅ Ultra Modern Loading with Glassmorphism & Gradient
  // static void showLoading({String message = "Loading..."}) {
  //   Get.dialog(
  //     PopScope(
  //       canPop: false,
  //       child: BackdropFilter(
  //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Background ko blur karega
  //         child: Center(
  //           child: Container(
  //             width: 60.w,
  //             padding: EdgeInsets.symmetric(vertical: 4.h),
  //             decoration: BoxDecoration(
  //               // White and Blue mixed gradient background
  //               gradient: LinearGradient(
  //                 colors: [Colors.white.withOpacity(0.9), Color(0xFFE3F2FD)],
  //                 begin: Alignment.topLeft,
  //                 end: Alignment.bottomRight,
  //               ),
  //               borderRadius: BorderRadius.circular(30),
  //               border: Border.all(color: Colors.white, width: 1.5),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.blue.withOpacity(0.2),
  //                   blurRadius: 20,
  //                   spreadRadius: 5,
  //                   offset: Offset(0, 10),
  //                 )
  //               ],
  //             ),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Spinning Gradient Loader
  //                 Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     SizedBox(
  //                       height: 55,
  //                       width: 55,
  //                       child: CircularProgressIndicator(
  //                         strokeWidth: 4,
  //                         valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1976D2)),
  //                         backgroundColor: Colors.blue.withOpacity(0.1),
  //                       ),
  //                     ),
  //                     // Center Logo or Icon
  //                     Icon(
  //                       Icons.auto_awesome_rounded,
  //                       color: Color(0xFF1976D2),
  //                       size: 22.sp,
  //                     ),
  //                   ],
  //                 ),
  //                 SizedBox(height: 3.h),
  //                 Material(
  //                   color: Colors.transparent,
  //                   child: Text(
  //                     message,
  //                     style: TextStyle(
  //                       fontSize: 14.sp,
  //                       color: Color(0xFF0D47A1), // Deep Blue color for text
  //                       fontWeight: FontWeight.bold,
  //                       letterSpacing: 1.2,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     barrierDismissible: false,
  //     barrierColor: Colors.black.withOpacity(0.3),
  //   );
  // }

  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}