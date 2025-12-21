
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/controllers/welcome_controller.dart';
import 'package:livsd/utils/App_Routing.dart';
import 'package:livsd/utils/init_binding.dart';
import 'package:livsd/views/auth_screens/splash_screen.dart';
import 'package:sizer/sizer.dart';

import 'constants/color_constants.dart';


Future<void> main() async{
Get.put(WelcomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          initialBinding: Binding(),
          initialRoute: '/',
          getPages: AppRoutes.routes,
          theme: ThemeData(
              scaffoldBackgroundColor: whiteColor
          ),
          home: SplashScreen(),
        );

      },
    );
  }
}

