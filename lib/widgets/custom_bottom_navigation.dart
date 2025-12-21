import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const CustomBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            height: 7.5.h,
            color: bottomnavigationclr,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _navIcon(0, 'assets/png/home.png'),
                _navIcon(1, 'assets/png/searches.png'),
                _navIcon(2, 'assets/png/heart (2).png'),
                _navIcon(3, 'assets/png/profiles.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navIcon(int index, String imagePath) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Container(
        height: 5.h,
        width: 11.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.w),
          color: isSelected
              ? whiteColors.withOpacity(0.25)
              : const Color(0x0DFFFFFF),
        ),
        child: Image.asset(
          imagePath,
          color: isSelected ? bluecolor : whiteColors,
        ),
      ),
    );
  }
}
