import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:livsd/views/dashboard/product_detail.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../widgets/rating_widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SecondScreen(),
    );
  }
}

Widget firstscreen(){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 3.h),
    child: Column(
      children: [

        Image.asset('assets/icon/logo.png', height: 7.h, width: 15.w),
        Row(
          children: [
            Container(
              width: 13.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(19),
                border: Border.all(
                  color: const Color(0xFFE6E6E6),
                  width: 1,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/heart.png',
                  height: 10.h,
                  width: 7.w,
                ),
              ),
            ),
            SizedBox(width: 3.w,),
            customText(
              text: "Your Favorites",
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              fontFamily: "SF Pro",
              color: fullblackd,
            ),
          ],
        ),
        SizedBox(height: 2.h,),
        Image.asset(
          'assets/png/favrouitscreen.png',
          height: 45.h,

          fit: BoxFit.cover,
        ),
        customText(
          text: "This could be you but you’ve got",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "SF Pro",
          color: otpscreenblue,
        ),customText(
          text: "no favorites :(",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          fontFamily: "SF Pro",
          color: otpscreenblue,
        ),
      ],
    ),
  );
}

Widget SecondScreen(){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 3.h),
    child: Column(
      children: [
        Image.asset('assets/icon/logo.png', height: 7.h, width: 15.w),
        Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 13.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: const Color(0xFFE6E6E6),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/heart.png',
                      height: 10.h,
                      width: 7.w,
                    ),
                  ),
                ),
                SizedBox(width: 3.w,),
                customText(
                  text: "Your Favorites",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "SF Pro",
                  color: fullblackd,
                ),
                SizedBox(width: 26.w),
                GestureDetector(
                  onTap: () {
                    print("See All tapped");
                  },
                  child: customText(
                    text: "See All",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "SF Pro",
                    color: brown,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 1,
              bottom: -1,
              top: 0,
              child: Image.asset(
                'assets/icon/forwardlogo.png',
                height: 3.1.h,
                width: 6.w,
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h,),
        DiscountCard(imagePath:'assets/png/frvtimg1.png',name: "Bali Hai Restaurant", location: "La Jolla",),
        SizedBox(height: 1.h,),
        DiscountCard(imagePath:'assets/png/frvtimg2.png' ,name :"Full Synthetic Oil Change",location: "La Jolla",),
        SizedBox(height: 1.h,),
        DiscountCard(imagePath:'assets/png/frvtimg3.png' , name :"Eye Lash Appointment",location: "Chula Vista",),

      ],

    ),
  );





}

Widget ProductDetailWidget({
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
                      imagePath: 'assets/png/foodimg2.png',
                      name: "Ahi Tuna",
                      price: "\$33",
                      onTap: () {}),
                  SizedBox(height: 2.h),
                  itemPrice(
                      imagePath: 'assets/png/foodimg2.png',
                      name: "Cup cake",
                      price: "\$22.80",
                      onTap: () {}),
                  SizedBox(height: 2.h),
                  itemPrice(
                      imagePath: 'assets/png/foodimg2.png',
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
class DiscountCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final String location;

  const DiscountCard({
    super.key,
    required this.imagePath,
    required this.name, required this.location,

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Get.toNamed('/Productdetailpage');
          },
          child: Container(
            height: 19.6.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: fullblack,
              borderRadius: BorderRadius.circular(5.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            height: 20.h, // specify height
            width: 50.w,  // specify width
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4.w),
                bottomRight: Radius.circular(5.w),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.fill, // BoxFit.fill ya BoxFit.fitHeight/fitWidth try karo
              ),
            ),
          ),
        ),


        Positioned(
          left: 20,
          top: 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 1.h),
              customText(
                text: name,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Nunito",
                color: whiteColors,
              ),

              SizedBox(height: 4.h),



            ],

          ),
        ),
        Positioned(
          top: 5.5.h,
          left: 5.5.w,
          child: Row(
            children: [
              Image.asset(
                'assets/png/burger.png',
                height: 5.h,
                width: 5.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 2.w),
              Image.asset(
                'assets/png/pet.png',
                height: 5.h,
                width: 5.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 2.w),
              Image.asset(
                'assets/png/Discount.png',
                height: 5.h,
                width: 5.w,
                fit: BoxFit.contain,
              ),
              SizedBox(width: 2.w),
              Image.asset(
                'assets/png/wifi-02.png',
                height: 5.h,
                width: 5.w,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        Positioned(
          top: 10.h,
          left: 6.w,
          child: Row(
            children: [
              Image.asset(
                'assets/png/locationpng.png',
                height: 6.h,
                width: 6.w,

              ),
              SizedBox(width: 2.w),
              customText(
                text:location,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "SF Pro",
                color: whiteColors,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
