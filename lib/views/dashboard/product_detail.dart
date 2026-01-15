import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/widgets/rating_widget.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/constants_widgets.dart';
import '../../constants/color_constants.dart';
import '../../controllers/product_controller.dart';
import '../../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key});
  final ProductController productController = Get.put(ProductController());
  @override
  // --- Screen Building Logic ---
  Widget build(BuildContext context) {
    final Id = Get.arguments;
    print(Id);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.getProductDetails(productId: Id);
    });
    return Scaffold(
      backgroundColor: whiteColor,
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: bluecolor));
        }

        if (productController.product.value?.data == null) {
          return Center(
            child: customText(
              text: "Product details not available", // Fixed: Access via detail
              fontSize: 19.sp,
              fontWeight: FontWeight.w600,
              color: blackColor,
            ),
          );
        }

        // ✅ Data pass karte waqt dhyaan rakhein ke model structure follow ho
        return ProductDetailWidget2(
            data: productController.product.value!.data!);
      }),
    );
  }

// --- Fixed Widget Logic ---
  Widget ProductDetailWidget2({required Data data}) {
    // Changed type from ProductModel to Data
    // Product details ko short variable mein store kar lete hain for easy access
    final detail = data.product;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 5.h),

            // --- Top Row: Back + Notification ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.all(4),
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
                      border: Border.all(
                          color: const Color(0xFFE6E6E6), width: 1),
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

            // --- Title & Cover Image ---
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  text: detail?.title ?? "No Title", // Fixed: Access via detail
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w600,
                  color: blackColor,
                ),
                SizedBox(height: 0.5.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 38.h,
                    width: 75.w,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      child: detail?.coverImage != null
                          ? Image.network(detail!.coverImage!)
                          : Container(color: greyColor),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 0.5.h),

            // --- Main Content Area ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 1.5.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: 6.h,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0.2.h,
                                left: 4.w,
                                child: Row(
                                  children: [
                                    StarRating(
                                      rating: (detail?.ratingAvg ?? 0)
                                          .toDouble(),
                                    ),
                                    SizedBox(width: 2.w),
                                    customText(
                                      text: "${detail?.ratingAvg ?? 0}",
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor,
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 4.h,
                                left: 9.w,
                                child: customText(
                                  text: "${detail?.ratingCount ?? 0} reviews",
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w700,
                                  color: greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(width: 0.3.w, height: 7.h, color: Colors.grey),
                      SizedBox(width: 5.w),
                      Flexible(
                        flex: 2,
                        child: SizedBox(
                          height: 7.h,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -3,
                                left: 3.w,
                                right: 0,
                                child: Row(
                                  children: [
                                    Image.asset('assets/png/locationicon.png',
                                        color: lightblu,
                                        height: 4.h,
                                        width: 4.w,
                                      fit: BoxFit.contain,
                                    ),

                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: customText(
                                        text: detail?.city ?? "No location",
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blueGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 3.h,
                                left: 3.w,
                                right: 0,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/png/time.png',
                                      color: lightblu,
                                      height: 4.h,
                                      width: 4.w,
                                      fit: BoxFit.contain, // ✅ Ye image ko box ke mutabiq cover kar lega
                                    ),

                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: customText(
                                        text: "5 min by car",
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: blueGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 3.h),

                  // Buttons
                  CustomButton(
                    borderRadius: BorderRadius.circular(23),
                    text: "Direction",
                    btnColor: blackColor,
                    fontWeight: FontWeight.w600,
                    height: 6.h,
                    width: 100.w,
                    onTap: () => Get.toNamed('/Otp'),
                  ),
                  SizedBox(height: 1.h),
                  CustomButton(
                    borderRadius: BorderRadius.circular(23),
                    text: "Add to Mydeals",
                    btnColor: bluecolor,
                    fontWeight: FontWeight.w600,
                    height: 6.h,
                    width: 100.w,
                    onTap: () => Get.toNamed('/Otp'),
                  ),

                  SizedBox(height: 3.h),

                  // Mini Images Gallery Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(3, (index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          (detail?.images != null &&
                              detail!.images!.length > index)
                              ? detail.images![index]
                              : "https://via.placeholder.com/150",
                          fit: BoxFit.cover,
                          height: 9.h,
                          width: 22.w,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.image, size: 9.h),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 3.h),

                  // Large Feature Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      (detail?.images != null && detail!.images!.length > 3)
                          ? detail.images![3]
                          : "https://via.placeholder.com/300",
                      fit: BoxFit.cover,
                      height: 18.h,
                      width: 90.w,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            color: greyColor[200],
                            height: 18.h,
                            width: 90.w,
                            child: const Icon(Icons.image_not_supported),
                          ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  customText(
                    text: "Most Popular",
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                    color: blackColor,
                  ),

                  SizedBox(height: 2.h),

                  // ✅ Related Products List from Data
                  if (data.relatedProducts != null)
                    ...data.relatedProducts!.map((item) =>
                        Padding(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: itemPrice(
                            // ✅ Title ki jagah coverImage use karein
                            imagePath: item.coverImage ?? 'https://via.placeholder.com/150',
                            name: item.title ?? "Item",
                            price: "\$${item.price ?? '0.0'}",
                            onTap: () {
                              // Click handle karein
                            },
                          ),
                        )).toList(),

                  SizedBox(height: 5.h),

                  // More Button
                  GestureDetector(
                    onTap: () => Get.toNamed('/ProductDetailScroll'),
                    child: SizedBox(
                      height: 6.h,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            left: 27.w,
                            top: 1.5.h,
                            child: customText(
                              text: "More",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: blueGray,
                            ),
                          ),
                          Positioned(
                            right: 28.w,
                            top: 1.1.h,
                            child: Image.asset(
                              'assets/png/logoforward.png',
                              height: 4.h,
                              width: 5.w,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 7.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget itemPrice({
  required String imagePath,
  required String name,
  required String price,
  required VoidCallback onTap,
  int? maxLines, // Isay add karein

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
            SizedBox(width: 10.h), // 🔥 image ki jagah reserve

            /// Name
            Expanded(
              child: customText(
                text: name,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "SF Pro",
                color: bottomnavigationclr,
                // ✅ In do properties ko ensure karein:
                maxLines: 2, // 2 ya usse zyada lines allow karein
                overFlow: TextOverflow.ellipsis, // Agar 2 lines se bhi bada ho to "..." dikhaye
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

            SizedBox(width: 2.5.w),

            /// Forward Button
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: 5.h,
                width: 5.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: blackColor,
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
          left: 1.5.w,
          bottom: 0.8.h,
          child: Container(
            height: 7.5.h,
            width: 7.5.h,
            decoration: BoxDecoration(
              // Border ya shadow agar dena chahen to yahan de sakte hain
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40), // Round shape ke liye
              child: Image.network(
                imagePath,
                fit: BoxFit.cover,
                // ✅ Ye loading ke waqt white screen nahi dikhayega
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator(strokeWidth: 2));
                },
                // ✅ Agar image na mile to ye icon dikhayega
                errorBuilder: (context, error, stackTrace) => Container(
                  color:greyColor[300],
                  child: Icon(Icons.broken_image, color: greyColor),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}


