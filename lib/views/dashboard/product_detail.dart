import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/widgets/rating_widget.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/constants_widgets.dart';
import '../../constants/color_constants.dart';

Widget ProductDetailWidget2({
  required String imagepath,
  required String imagepath1,
  required String imagepath2,
  required String imagepath3,
  required String imagepath4,
  required String name,
  required int initialIndex,
  required String rating,
  required String review,required String location,
}) {
  final pageController = PageController(
      initialPage: initialIndex,
      viewportFraction: 0.75
  );
  final currentIndexNotifier = ValueNotifier<int>(initialIndex);

  return  Scaffold( body:
  Column(
    children: [
      SizedBox(height: 4.h,),

      // Top Row: Back + Notification
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(4),
                child: Image.asset(
                  'assets/png/roundedbackbutton.png',
                  height: 3.h,
                  width: 5.w,
                ),
              ),
            ),
            Container(
              width: 14.w,
              height: 6.5.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(21),
                border: Border.all(color: const Color(0xFFE6E6E6), width: 1),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/heart.png',
                  height: 3.h,
                  width: 6.w,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 2.h),
      // Image PageView
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customText(
            text: name,
            fontSize: 19.sp,
            fontWeight: FontWeight.w600,
            color: fullblackd,
          ),
          SizedBox(height: 0.5.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 45.h, // Image height directly control
              width: 85.w,
              child: FittedBox(
                fit: BoxFit.cover, // ❌ top se crop ho sakta tha agar direct BoxFit.cover
                alignment: Alignment.topCenter, // ✅ top se crop avoid
                child: Image.asset(imagepath),
              ),
            ),
          ),
        ],
      ),






      // Content
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: ValueListenableBuilder<int>(
              valueListenable: currentIndexNotifier,
              builder: (context, currentIndex, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.5.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                StarRating(
                                  rating: double.tryParse(rating) ?? 0,
                                ),
                                SizedBox(width: 2.w),
                                customText(
                                  text: rating,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "SF Pro",
                                  color: darkGrayColor,
                                ),
                              ],
                            ),
                            SizedBox(height: 0.5.h),
                            customText(
                              text: review,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SF Pro",
                              color: abababColor,
                            ),
                          ],
                        ),
                      ),

                      Container(width: 0.3.w, height: 6.5.h, color: dividerColor),
                      SizedBox(width: 5.w),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/png/locationlogo.png',
                                  height: 3.5.h,
                                  width:3.5.w,
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: customText(
                                    text: location,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SF Pro",
                                    color: bottomnavigationclr,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/png/time.png',
                                  height: 3.h,
                                  width: 3.w,
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: customText(
                                    text: "5 min by car",
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "SF Pro",
                                    color: bottomnavigationclr,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  CustomButton(
                    borderRadius: BorderRadius.circular(15),
                    text: "Direction",
                    btnColor: darkColor,
                    fontWeight: FontWeight.w600,
                    height: 6.h,
                    width: 92.w,
                    onTap: () {
                      Get.toNamed('/Otp');
                    },
                  ),
                  SizedBox(height: 1.h),
                  CustomButton(
                    borderRadius: BorderRadius.circular(15),
                    text: "Add to Mydeals",
                    btnColor: otpscreenblue,
                    fontWeight: FontWeight.w600,
                    height: 6.h,
                    width: 92.w,
                    onTap: () {
                      Get.toNamed('/Otp');
                    },
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        imagepath1,
                        fit: BoxFit.cover,
                        height: 9.h,
                      ),
                      Image.asset(
                        imagepath2,
                        fit: BoxFit.cover,
                        height: 9.h,
                      ),
                      Image.asset(
                        imagepath3,
                        fit: BoxFit.cover,
                        height: 9.h,
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagepath4,
                      fit: BoxFit.cover,
                      height: 18.h,
                      width: 90.w,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  customText(
                    text: "Most Popular",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "SF Pro",
                    color: bottomnavigationclr,

                  ),
                  SizedBox(height: 2.h),
                  itemPrice(
                      imagePath: 'assets/png/cofee.png',
                      name: "Coffee",
                      price: "\$5.80",
                      onTap: () {}),
                  SizedBox(height: 2.h),
                  itemPrice(
                      imagePath: 'assets/png/cofee.png',
                      name: "Coffee",
                      price: "\$5.80",
                      onTap: () {}),
                  SizedBox(height: 2.h),
                  itemPrice(
                      imagePath: 'assets/png/cofee.png',
                      name: "Coffee",
                      price: "\$5.80",
                      onTap: () {}),

                  SizedBox(height: 5.h),

                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        '/ProductDetailScroll',

                      );
                    },


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                          text: "More",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "SF Pro",
                          color: bottomnavigationclr,
                        ),
                        SizedBox(width: 2.w),
                        Image.asset(
                          'assets/png/logoforward.png',
                          height: 3.h,
                          width: 5.w,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 7.h,),

                ],
              ),
            ),
          ),
        ),
      ),
    ],
  ),
  );
}
Widget itemPrice({
  required String imagePath,
  required String name,
  required String price,
  required VoidCallback onTap,
}) {
  return Container(
    width: 75.w,
    height: 9.h,
    padding: EdgeInsets.symmetric(horizontal: 2.w),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0x80000000), width: 0.4),
      borderRadius: BorderRadius.circular(40),
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [

        /// 🔹 MAIN ROW CONTENT
        Row(
          children: [
            SizedBox(width: 9.h), // 🔥 image ki jagah reserve

            /// Name
            Expanded(
              child: customText(
                text: name,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "SF Pro",
                color: bottomnavigationclr,
              ),
            ),

            /// Price
            customText(
              text: price,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "SF Pro",
              color: bottomnavigationclr,
            ),

            SizedBox(width: 3.w),

            /// Forward Button
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 5.h,
                width: 5.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: bluecolor,
                  size: 18.sp,
                ),
              ),
            ),
          ],
        ),

        /// 🔹 POSITIONED IMAGE (fully controllable)
        Positioned(
          left: -4.w,
          bottom:-2.7.h,
          // 👈 change freely
          // 👈 upar / niche move
          child: Container(
            height: 12.h,
            width: 12.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}