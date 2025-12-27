import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:livsd/views/auth_screens/otp_input_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Aapke custom imports
import '../outh_file/local_db_key.dart';
import '../services/base_url.dart';
import '../services/endpoint.dart';
import '../utils/shared_prefrences_methods.dart';
import '../utils/utility.dart';
import '../widgets/sucess_dialog.dart';
import '../widgets/util.dart'; // Ensure correct spelling

class AuthController extends GetxController {
  // --- Observables & Variables ---
  var userName = "".obs;
  var userProfilePic = "".obs;
  var userEmail = "".obs;
  var userPhone = "".obs;
  String resetToken = '';
  String email = ''; // OTP verification ke liye

  // API Service Instance
  BaseService baseService = BaseService();
  final prefs = SharedPreferencesMethod.storage;

  // UI State
  RxBool isPasswordVisible = true.obs;
  var otp = "".obs;

  // --- Text Controllers ---
  final loginEmailField = TextEditingController();
  final loginPasswordField = TextEditingController();

  final signupNameField = TextEditingController();
  final signupEmailField = TextEditingController();
  final signupPhoneField = TextEditingController();
  final signupPasswordField = TextEditingController();

  final otpField = TextEditingController();
  final forgotPassword = TextEditingController();

  final forgotEmailField = TextEditingController();
  final forgotNewPassField = TextEditingController();
  final forgotConfirmPassField = TextEditingController();

  // --- Password Visibility Toggle ---
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  // --- LOGIN API ---
  Future<void> signUp() async {
    final body = {
      "name": signupNameField.text.trim(),
      "email": signupEmailField.text.trim(),
      "password": signupPasswordField.text.trim(),
      "phone": signupPhoneField.text.trim(),
    };

    try {

      final response = await baseService.basePostAPI(ApiEndPoints.signupUser, body);
      print(response);
      if (response != null && response['success'] == true) {
        final user = response['user'];

         await prefs.setString(LocalDBKeys.TOKEN, user['token'] ?? "");
         await prefs.setString(LocalDBKeys.USERFULLNAME, user['name'] ?? "");
         await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? "");
        clearSignupValues();
        Get.toNamed('/Verification');

        Utils.showToast(response['msg'] ?? "Signup successful", false);
      }
    } catch (e) {
      Utils.showToast("Signup Error: ${e.toString()}", true);
    }
  }


  Future<void> login() async {
    final body = {
      "email": loginEmailField.text.trim(),
      "password": loginPasswordField.text.trim(),
    };

    try {
      final response = await baseService.basePostAPI(ApiEndPoints.loginUser, body);

      if (response != null && response['success'] == true) { // corrected 'success'
        final user = response['user'];

        await prefs.setString(LocalDBKeys.TOKEN, user['token'] ?? '');
        await prefs.setString(LocalDBKeys.USERFULLNAME, user['name'] ?? "");
        await prefs.setString(LocalDBKeys.USEREMAIL, user['email'] ?? '');
        clearLoginValues();
        Get.offAllNamed('/navbar');

        Utils.showToast(response['msg'] ?? "Login successful", false);
      } else {
        Utils.showToast(response['msg'] ?? "Invalid credentials", true);
      }
    } catch (e) {
      Utils.showToast("Login Error: ${e.toString()}", true);
    }
  }
  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // 1. Local storage se data delete karein
      await prefs.remove('email');

      await prefs.remove('locationDialogShown');


      await prefs.remove('notificationDialogShown');
      await prefs.remove('name');
      // Agar sab kuch delete karna hai to: await prefs.clear();

      // 2. GetX ki madad se Login screen par navigate karein
      // Get.offAll() purani sari screens (history) ko khatam kar deta hai
      Get.offAllNamed('/Login');

      // Agar aapne routes define nahi kiye to aise karein:
      // Get.offAll(LoginScreen());

    } catch (e) {
      Get.snackbar("Error", "not logout");
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    // 1. Validation
    if (otp.value.isEmpty || otp.value.length < 6) {
      Utils.showToast('Please enter the 6-digit code', true);
      return;
    }

    final body = {
      "otp": otp.value,
      "otpType": "VERIFY_EMAIL"
    };

    try {
      // loading: true user ko wait karne ka signal deta hai
      var response = await baseService.basePostAPI(
        ApiEndPoints.verifyOtp,
        body,
        loading: true,
      );

      // 2. Response Check
      // Response handling
      if (response != null && (response['success'] == true || response['statusCode'] == 200)) {
        Utils.showToast(response['message'] ?? 'OTP Verified Successfully', false);

        // Data clear karein
        otp.value = '';

        // Direct success screen pe bhejna (Extra brackets hata diye gaye hain)
        Get.toNamed("/sucess");

      } else {
        // Agar OTP galat ho
        Utils.showToast(response?['message'] ?? 'Invalid OTP, please try again', true);
      }
    } catch (e) {
      Utils.showToast('Error: ${e.toString()}', true);
    }
  }
  Future<void> sendOtp() async { // Parameter hata diya kyunki aap controller use kar rahe hain

    // 1. Controller se value nikaal kar check karein
    String emailInput = forgotPassword.text.trim();

    if (emailInput.isEmpty || !GetUtils.isEmail(emailInput)) {
      Utils.showToast('Please enter a valid email address', true);
      return;
    }

    // 2. Request Body
    final body = {
      "email": forgotPassword.text.trim(), // Variable use karein jo upar trim kiya hai
    };

    print("Sending OTP to: $body");

    try {
      var response = await baseService.basePostAPI(
        ApiEndPoints.forgotPassword,
        body,
        loading: true,
      );

      // 3. Response Handling
      if (response != null && (response['success'] == true || response['statusCode'] == 200)) {
        Utils.showToast(response['message'] ?? 'OTP sent successfully', false);

        // Agli screen par email bhej rahe hain taaki wahan user ko dikha saken
        Get.toNamed('/Verification', arguments: emailInput);

      } else {
        Utils.showToast(response?['message'] ?? 'Failed to send OTP', true);
      }
    } catch (e) {
      Utils.showToast('Error: ${e.toString()}', true);
    }
  }
  void clearSignupValues(){
  signupNameField.clear();
  signupEmailField.clear();
  signupPhoneField.clear();
  signupPasswordField.clear();
}

void clearLoginValues(){
  loginEmailField.clear();
  loginPasswordField.clear();
}
@override
  void onClose() {
    // TODO: implement onClose

    super.onClose();
  }

}
