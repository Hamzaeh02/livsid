// import 'dart:convert';
// import 'dart:io';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../widgets/util.dart';
// import 'base_url.dart';
// import 'endpoint.dart';
//
//
//
// class AuthController extends GetxController {
//   // Controllers (Ensure ye aapke UI se linked hain)
//   final signupNameField = TextEditingController();
//   final signupEmailField = TextEditingController();
//   final signupPasswordField = TextEditingController();
//   final signupConfirmPasswordField = TextEditingController();
//   final loginEmailField = TextEditingController();
//   final loginPasswordField = TextEditingController();
//
//   var fullPhoneNumber = "".obs; // Number field ke liye
//   var email = "";
//
//   /// --- SIGN UP API ---
//   Future<void> signUp({File? profilePicture}) async {
//     // Basic Validation
//     if (signupPasswordField.text != signupConfirmPasswordField.text) {
//       Utils.showToast("Passwords do not match", true);
//       return;
//     }
//
//     try {
//       Utils.showLoading(); // Agar aapke paas loading utility hai
//
//       final uri = Uri.parse("${BaseService().baseURL}${ApiEndPoints.signupUser}");
//       final request = http.MultipartRequest('POST', uri);
//
//       // Backend requirements ke mutabiq keys
//       request.fields['name'] = signupNameField.text.trim();
//       request.fields['email'] = signupEmailField.text.trim();
//       request.fields['password'] = signupPasswordField.text.trim();
//       request.fields['number'] = fullPhoneNumber.value; // 'phone' ki jagah 'number'
//
//       // Profile Picture attachment
//       if (profilePicture != null && profilePicture.existsSync()) {
//         final extension = profilePicture.path.split('.').last;
//         request.files.add(await http.MultipartFile.fromPath(
//           'profilePicture',
//           profilePicture.path,
//           contentType: MediaType('image', extension),
//         ));
//       }
//
//       print("⏳ Requesting: $uri");
//       print("➡ Body: ${request.fields}");
//
//       final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
//       final responseString = await streamedResponse.stream.bytesToString();
//       final responseMap = json.decode(responseString);
//
//       Utils.hideLoading();
//
//       if (streamedResponse.statusCode == 201 || streamedResponse.statusCode == 200) {
//         Utils.showToast(responseMap['message'] ?? "Signup successful", false);
//
//         // Data save karein
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('userName', signupNameField.text.trim());
//
//         email = signupEmailField.text.trim();
//
//         // Navigation
//         Get.offAllNamed("/verification");
//         clearSignupFields();
//       } else {
//         Utils.showToast(responseMap['message'] ?? "Signup failed", true);
//       }
//     } on SocketException {
//       Utils.hideLoading();
//       Utils.showToast("No Internet Connection", true);
//     } catch (e) {
//       Utils.hideLoading();
//       print("Signup Error: $e");
//       Utils.showToast("Something went wrong", true);
//     }
//   }
//
//   /// --- LOGIN API ---
//   Future<void> login() async {
//     if (loginEmailField.text.isEmpty || loginPasswordField.text.isEmpty) {
//       Utils.showToast("Please fill all fields", true);
//       return;
//     }
//
//     final body = {
//       'email': loginEmailField.text.trim(),
//       'password': loginPasswordField.text.trim(),
//     };
//
//     try {
//       // Base POST API call
//       final response = await BaseService().basePostAPI(
//         ApiEndPoints.loginUser,
//         body,
//         loading: true,
//       );
//
//       if (response != null && response['data'] != null) {
//         final data = response['data'];
//         final user = data['user'];
//         final token = data['accessToken'];
//
//         // Token aur User Info save karein
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);
//         await prefs.setString('userData', jsonEncode(user));
//         await prefs.setString('userEmail', user['email'] ?? "");
//
//         Utils.showToast(response['message'] ?? "Welcome Back!", false);
//
//         Get.offAllNamed('/bottomnavbar');
//         clearLoginFields();
//       } else {
//         Utils.showToast(response?['message'] ?? "Invalid Credentials", true);
//       }
//     } catch (e) {
//       print("Login Error: $e");
//       Utils.showToast("Login failed. Try again.", true);
//     }
//   }
//
//   void clearSignupFields() {
//     signupNameField.clear();
//     signupEmailField.clear();
//     signupPasswordField.clear();
//     signupConfirmPasswordField.clear();
//     fullPhoneNumber.value = "";
//   }
//
//   void clearLoginFields() {
//     loginEmailField.clear();
//     loginPasswordField.clear();
//   }
// }