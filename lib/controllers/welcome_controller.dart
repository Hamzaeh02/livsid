import 'package:get/get.dart';
import 'package:livsd/outh_file/local_db_key.dart';
import 'package:livsd/utils/shared_prefrences_methods.dart';

class WelcomeController extends GetxController {
  var currentPage = 0.obs;
  var selectedIndex = 0.obs;
  var bottomNavIndex = 0.obs;// already exists, we will use it for category selection
  final pref = SharedPreferencesMethod.storage;
  @override
  void onReady() { // onInit ki jagah onReady use karein
    super.onReady();
    _startTimer();
  }
  void _startTimer() {
    // Safe tareeke se token lein
    final token = pref.getString(LocalDBKeys.TOKEN);
    print("Token is: $token");

    // Logic: Agar token null nahi hai aur khali bhi nahi hai
    if (token != null && token.isNotEmpty) {
      // Agar login hai to foran navbar pe jayein
      Get.offAllNamed("/navbar");
    } else {
      // Agar login nahi hai to 3 second baad login pe jayein
      Future.delayed(const Duration(seconds: 3), () {
        Get.offAllNamed('/Login');
      });
    }
  }

  // -----------------------------
  // CATEGORY SELECTION LOGIC
  // -----------------------------
  void selectCategory(int index) {
    selectedIndex.value = index; // update selected button index
  }
}
