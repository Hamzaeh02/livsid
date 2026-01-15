import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/outh_file/local_db_key.dart';
import 'package:livsd/utils/shared_prefrences_methods.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  var selectedIndex = 0.obs;
  var bottomNavIndex = 0.obs;

  // Use a getter to handle potential nulls safely
  final pref = SharedPreferencesMethod.storage;

  @override
  void onReady() {
    super.onReady();
    _checkTokenAndNavigate();
  }

  void _checkTokenAndNavigate() {
    try {
      // 1. Safety Check: If storage is somehow null, don't crash
      if (pref == null) {
        debugPrint("Error: SharedPreferences not initialized");
        Future.delayed(const Duration(seconds: 2), () => Get.offAllNamed('/Login'));
        return;
      }

      final token = pref.getString(LocalDBKeys.TOKEN);
      print("Token is: $token");

      if (token != null && token.isNotEmpty) {
        // Use a small delay to ensure the UI tree is ready for navigation
        Future.delayed(Duration.zero, () {
          Get.offAllNamed("/navbar");
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed('/Login');
        });
      }
    } catch (e) {
      debugPrint("Welcome Screen Crash caught: $e");
      // Fallback to login if something fails
      Get.offAllNamed('/Login');
    }
  }

  void selectCategory(int index) {
    selectedIndex.value = index;
  }
}