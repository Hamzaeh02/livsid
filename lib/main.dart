
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:livsd/controllers/auth_controller.dart';
import 'package:livsd/controllers/weather_controller.dart';
import 'package:livsd/controllers/welcome_controller.dart';
import 'package:livsd/utils/App_Routing.dart';
import 'package:livsd/utils/init_binding.dart';
import 'package:livsd/utils/shared_prefrences_methods.dart';
import 'package:livsd/views/auth_screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'constants/color_constants.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final pref = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(pref,permanent: true);
Get.put(WelcomeController());
Get.put(AuthController());

  runApp(const MyApp());
}

// ... baki imports

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false, // Optional: debug banner hatane ke liye
          initialBinding: Binding(),
          initialRoute: '/', // Ye kafi hai, kyunki '/' routes mein Splash hai
          builder: EasyLoading.init(),
          getPages: AppRoutes.routes,
          theme: ThemeData(
              scaffoldBackgroundColor: whiteColor
          ),
          // home: SplashScreen(),  <-- Is line ko DELETE kar dein ya comment kar dein
        );
      },
    );
  }
}

