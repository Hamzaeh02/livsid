import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../controllers/welcome_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final WelcomeController controller = Get.find<WelcomeController>();

  @override
  Widget build(BuildContext context) {
     // logic in controller ✅

    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.3, end: 1.0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Image.asset(
            "assets/icon/logo.png",
            height: 22.h, // Sizer used ✅
            width: 22.h,  // square logo
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
