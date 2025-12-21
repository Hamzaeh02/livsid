import 'package:get/get.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  var selectedIndex = 0.obs;
  var bottomNavIndex = 0.obs;// already exists, we will use it for category selection

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }
  void changeBottomNav(int index) {
    bottomNavIndex.value = index;
  }
  void _startTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      // Splash ke baad next screen
      Get.offAllNamed('/Login'); // stack se remove, back press se splash nahi aayega
    });
  }

  // -----------------------------
  // CATEGORY SELECTION LOGIC
  // -----------------------------
  void selectCategory(int index) {
    selectedIndex.value = index; // update selected button index
  }
}
