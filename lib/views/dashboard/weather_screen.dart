import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/weather_controller.dart';

class WeatherScreen extends StatelessWidget {
  WeatherScreen({super.key});
  final WeatherController controller = Get.put(WeatherController());

  // API aksar lowercase bhejti hai, isliye keys small rakhi hain
  final Map<String, dynamic> weatherData = {
    'clear': {
      'gradient': const LinearGradient(colors: [Color(0xFF4facfe), Color(0xFF00f2fe)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/hazzy.png',
      'textColor': whiteColor,
    },
    'thunderstorm': {
      'gradient': const LinearGradient(colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/thunderstrom.png',
      'textColor': whiteColor,
    },
    'haze': {
      'gradient': const LinearGradient(colors: [Color(0xFF8e9eab), Color(0xFFeef2f3)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/hazzy.png',
      'textColor': Color(0xFF333333),
    },
    'mist': { // Haze jaisa hi hota hai
      'gradient': const LinearGradient(colors: [Color(0xFF8e9eab), Color(0xFFeef2f3)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/thunderstrom.png',
      'textColor': Color(0xFF333333),
    },
    'clouds': {
      'gradient': const LinearGradient(colors: [Color(0xFFbdc3c7), Color(0xFF2c3e50)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/sunnyweather.png',
      'textColor': whiteColor,
    },
    'rain': {
      'gradient': const LinearGradient(colors: [Color(0xFF203A43), Color(0xFF2C5364)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/thunderstrom.png',
      'textColor':whiteColor,
    },
    'snow': {
      'gradient': const LinearGradient(colors: [Color(0xFFE6E9F0), Color(0xFFEEF1F5)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      'image': 'assets/png/snow3.png',
      'textColor': Color(0xFF333333),
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // API se aane wali condition ko lowercase mein convert karna zaroori hai
        // takay map ki keys se match ho sakay
        String conditionKey = controller.condition.value.toLowerCase().trim();

        // Agar API se aisi condition aaye jo map mein nahi hai, to 'clear' default dikhayega
        final currentWeather = weatherData[conditionKey] ?? weatherData['clear']!;

        return Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(gradient: currentWeather['gradient']),
          child: SafeArea( // StatusBar ke upar text na chadhe
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- TOP BAR ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(Icons.arrow_back, color: currentWeather['textColor']),
                      ),
                      customText(
                        text: TimeOfDay.now().format(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: currentWeather['textColor'],
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  // Location
                  customText(
                    text: controller.location.value,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: currentWeather['textColor'],
                  ),

                  // --- WEATHER MAIN SECTION ---
                  SizedBox(height: 4.h),
                  Image.asset(
                    currentWeather['image'],
                    height: 22.h,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 3.h),

                  // API Condition Text (Upper Case First Letter for UI)
                  customText(
                    text: controller.condition.value.capitalizeFirst ?? "",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: currentWeather['textColor'],
                  ),

                  // Temp
                  customText(
                    text: "${controller.temp.value}°",
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: currentWeather['textColor'],
                  ),

                  const Spacer(),

                  // --- INFO CARD ---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 4.w),
                        decoration: BoxDecoration(
                          color: currentWeather['textColor'] == whiteColor
                              ? whiteColor.withOpacity(0.15)
                              : blackColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: currentWeather['textColor'].withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _smallInfo("Feels Like", "${controller.feelsLike.value}°", currentWeather['textColor']),
                            _smallInfo("Humidity", "${controller.humidity.value}%", currentWeather['textColor']),
                            _smallInfo("Wind", "${controller.windSpeed.value} km/h", currentWeather['textColor']),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _smallInfo(String title, String value, Color color) {
    return Column(
      children: [
        customText(text: title, fontSize: 12.sp, color: color.withOpacity(0.8)),
        SizedBox(height: 0.5.h),
        customText(text: value, fontSize: 14.sp, fontWeight: FontWeight.bold, color: color),
      ],
    );
  }
}