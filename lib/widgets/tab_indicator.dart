import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';

Widget tabIndicators(int currentIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(5, (index) {
      bool isActive = index == currentIndex;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 8,
        width: isActive ? 8 : 8, // active indicator wider
        decoration: BoxDecoration(
          color: isActive ? blackColor : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }),
  );
}

