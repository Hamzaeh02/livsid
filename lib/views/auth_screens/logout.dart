import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/auth_controller.dart';
import '../../utils/shared_prefrences_methods.dart';
// Import your login screen here
// import 'package:your_app/screens/login_screen.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  // --- THE LOGOUT FUNCTION ---

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final pref = SharedPreferencesMethod.storage;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Settings"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.logout_rounded, size: 100, color: Colors.blueGrey),
              const SizedBox(height: 20),
              const Text(
                "Are you sure you want to logout?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 40),

              // --- LOGOUT BUTTON ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    // Calling the logout function here
                    SharedPreferencesMethod.clearLocalStorage();
                    Get.offAllNamed('/Login');
                    // authController.logout();
                  },
                  child: const Text(
                    "LOGOUT NOW",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}