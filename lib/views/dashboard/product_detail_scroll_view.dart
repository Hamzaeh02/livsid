import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livsd/constants/color_constants.dart';
import 'package:livsd/views/dashboard/product_detail.dart';
import 'package:sizer/sizer.dart';

import '../../constants/constants_widgets.dart' show customText;
import '../../widgets/rating_widget.dart';

class ProductDetailScrollView extends StatefulWidget {
  const ProductDetailScrollView({super.key});

  @override
  State<ProductDetailScrollView> createState() => _ProductDetailScrollViewState();
}

class _ProductDetailScrollViewState extends State<ProductDetailScrollView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: itemMenu( 'assets/png/resturant.png',name: " MoonBean's\n Coffee" ,rating: "4.7",review: "64,57,342 Reviews",area: "19 Santa \nTeresa Blvd,\nSan Jose, CA"),
    );
  }
}
Widget itemMenu(
String topImage, // positional
    {
      required String name, required String rating, required String review,required String area,


}
) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        // 🔹 TOP IMAGE
        ClipRRect(
          child: Image.asset(
            topImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 33.h,
          ),
        ),

        // 🔹 CONTENT CONTAINER overlapping image
        Container(
          margin: EdgeInsets.only(top: 24.h), // container top thoda upar image ke andar
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColors,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 3.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME + HEART ICON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: customText(
                        text: name,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Inter",
                        color: fullblack,
                      ),
                    ),
                    Container(
                      width: 14.w,
                      height: 6.5.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        borderRadius: BorderRadius.circular(21),
                        border: Border.all(
                          color: const Color(0xFFE6E6E6),
                          width: 1,
                        ),
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

                SizedBox(height: 2.h),

                // RATING + AREA
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              StarRating(rating: 4),
                              SizedBox(width: 2.w),
                              customText(
                                text: rating,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: "SF Pro",
                                color: fullblack,
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
                    SizedBox(width: 3.w),
                    Container(
                      width: 0.3.w,
                      height: 5.h,
                      color: dividerColor,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/png/locationlogo.png',
                            height: 4.h,
                            width: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: customText(
                              text: area,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: "SF Pro",
                              color: fullblack,
                            ),
                          ),
                          Container(
                            height: 3.h,
                            width: 3.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color:blackColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: bluecolor,
                              size: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),
                Container(width: 80.w, height: 0.1.h, color: dividerColor),
                SizedBox(height: 3.h),

                // MOST POPULAR
                customText(
                  text: "Most Popular",
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                  color: fullblack,
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
                    name: "Latte",
                    price: "\$6.50",
                    onTap: () {}),

                SizedBox(height: 3.h),

                // OUR MENU
                customText(
                  text: "Our Menu",
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Inter",
                  color: fullblack,
                ),
                SizedBox(height: 2.h),
                Center(
                  child: customText(

                    text: "15+ min pre order only",
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Inter",
                    color: abababColor,
                  ),
                ),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Espresso",
                    price: "\$5.00",
                    onTap: () {}),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Cappuccino",
                    price: "\$6.00",
                    onTap: () {}),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Espresso",
                    price: "\$5.00",
                    onTap: () {}),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Cappuccino",
                    price: "\$6.00",
                    onTap: () {}),
                SizedBox(height: 2.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Espresso",
                    price: "\$5.00",
                    onTap: () {}),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Cappuccino",
                    price: "\$6.00",
                    onTap: () {}),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Espresso",
                    price: "\$5.00",
                    onTap: () {}),
                SizedBox(height: 1.h),
                itemPrice(
                    imagePath: 'assets/png/cofee.png',
                    name: "Cappuccino",
                    price: "\$6.00",
                    onTap: () {}),
              ],
            ),
          ),
        ),
      ],
    ),
  );

}
