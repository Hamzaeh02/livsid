import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String condition = 'Partly Cloudy'; // Default condition
  String location = 'San Diego';
  String time = '11:00';
  String temp = '74°';

  @override
  Widget build(BuildContext context) {
    // Map condition to gradient, image, textColor, and iconColor
    Map<String, dynamic> weatherData = {
      'Sunny': {
        'gradient': LinearGradient(
          colors: [Color(0xFF2F5AF4), Color(0xFF0FA2AB)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        'image': 'assets/png/sunny.png',
        'textColor': whiteColors,
        'iconColor': whiteColors,
      },
      'Thunderstorm': {
        'gradient': LinearGradient(
          colors: [Color(0xFFBCE8FF), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        'image': 'assets/png/thunderstrom.png',
        'textColor': fullblack,
        'iconColor': fullblack, // icon black for thunderstorm
      },
      'Partly Cloudy': {
        'gradient': LinearGradient(
          colors: [weatherclr, weatherclr],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        'image': 'assets/png/sunnyweather.png',
        'textColor': whiteColors,
        'iconColor': whiteColors,
      },
    };

    final currentWeather = weatherData[condition]!;

    return Scaffold(
      body: weatherCard(
        condition: condition,
        location: location,
        time: time,
        temp: temp,
        gradient: currentWeather['gradient'],
        imagePath: currentWeather['image'],
        textColor: currentWeather['textColor'],
        iconColor: currentWeather['iconColor'],
      ),
    );
  }
}

Widget weatherCard({
  required String condition,
  required String location,
  required String time,
  required String temp,
  required LinearGradient gradient,
  required String imagePath,
  required Color textColor,
  required Color iconColor,
}) {
  return Container(
    height: 100.h,
    width: 100.w,
    decoration: BoxDecoration(
      gradient: gradient,
    ),
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Top Row: Back arrow + Time
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_back,
              color: iconColor, // dynamic icon color
              size: 6.w, // adjust size
            ),
            customText(
              text: time,
              fontSize: 16.sp, // increased size
              fontWeight: FontWeight.w500, // adjusted weight
              fontFamily: "SF Pro",
              color: textColor,
            ),
          ],
        ),

        SizedBox(height: 5.h),

        // Location
        customText(
          text: location,
          fontSize: 22.sp, // increased font size
          fontWeight: FontWeight.w600, // stronger weight
          fontFamily: "SF Pro",
          color: textColor,
        ),

        SizedBox(height: 2.h),

        // Weather Image
        Image.asset(
          imagePath,
          height: 37.h, // slightly larger
          width: 50.w,
          fit: BoxFit.contain,
        ),

        SizedBox(height: 3.h),

        // Condition Text
        customText(
          text: condition,
          fontSize: 21.sp, // increased
          fontWeight: FontWeight.w500,
          fontFamily: "SF Pro",
          color: textColor,
        ),

        SizedBox(height: 4.h),

        // Temperature
        customText(
          text: temp,
          fontSize: 32.sp, // bigger temperature
          fontWeight: FontWeight.w900, // bold
          fontFamily: "SF Pro",
          color: textColor,
        ),
      ],
    ),
  );
}
