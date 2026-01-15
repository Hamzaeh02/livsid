import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/models/promoted_product.dart';
import 'package:livsd/outh_file/local_db_key.dart';
import 'package:livsd/utils/shared_prefrences_methods.dart';
import 'package:livsd/views/dashboard/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/search_controller.dart';
import '../../controllers/welcome_controller.dart';
import '../../widgets/custom_bottom_navigation.dart';
import '../../widgets/cutout_clipper.dart';
import '../../widgets/tab_indicator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();

}
final WelcomeController controller = Get.put(WelcomeController());
final WelcomeControllers shopLocalController = Get.put(WelcomeControllers());

final ProductController productController = Get.put(ProductController());
final PageController pageController = PageController(  viewportFraction: 0.45,);
final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);


class _WelcomeScreenState extends State<WelcomeScreen> {
  int _selectedIndex = 0;
  @override
  bool _isDialogShowing = false;
  bool _isDialogLogicRunning = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowDialogs();
    });
  }

  Future<void> _checkAndShowDialogs() async {
    if (_isDialogShowing) return; // Agar pehle se dikh raha hai toh rukh jao

    final prefs = await SharedPreferences.getInstance();
    final bool locationShown = prefs.getBool('locationDialogShown') ?? false;
    final bool notificationShown = prefs.getBool('notificationDialogShown') ?? false;

    if (!locationShown) {
      _isDialogShowing = true;
      _showLocationDialog();
      await prefs.setBool('locationDialogShown', true);
    } else if (!notificationShown) {
      _isDialogShowing = true;
      _showNotificationDialog();
      await prefs.setBool('notificationDialogShown', true);
    }
  }
  // Google Location dialog
// ✅ First Dialog: Location
  // ✅ First Dialog: Location
  void _showLocationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent, // Background transparent rakha hai taake design clean lage
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none, // Isse icon boundary se bahar nikal sakta hai
          children: [
            // Main Container
            Container(
              width: 85.w,
              padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5.h), // Top icon ke liye space

                  // Center Logo
                  Image.asset(
                      'assets/icon/dailboxlogo.png',
                      height: 13.h,
                      fit: BoxFit.contain
                  ),

                  SizedBox(height: 2.h),
                  customText(
                    text: "Location",
                    fontSize: 20.sp,
                    color: black1,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 1.5.h),
                  customText(
                    text: "Allow maps to access your location while you use the app?",
                    fontSize: 16.sp,
                    color: black2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4.h),

                  // Continue Button
                  CustomButton(
                    borderRadius: BorderRadius.circular(40),
                    text: "Continue",
                    btnTextColor: whiteColor,
                    fontWeight: FontWeight.bold,
                    height: 6.h,
                    width: double.infinity,
                    onTap: () {
                      Get.back();
                      _showNotificationDialog();
                    },
                    gradientColor: LinearGradient(
                      colors: [Color(0xFF00BBFF), Color(0xFF26AFE9)],
                    ),
                  ),
                  SizedBox(height: 1.5.h),

                  // Skip Button
                  CustomButton(
                    borderRadius: BorderRadius.circular(40),
                    text: "Skip for now",
                    btnTextColor: blackColor,
                    borderColor: blackColor,
                    height: 6.h,
                    width: double.infinity,
                    btnColor: whiteColor,
                    onTap: () {
                      Get.back();
                      _showNotificationDialog();
                    },
                  ),
                ],
              ),
            ),

            // Top Floating Location Icon (Jo pehle miss ho raha tha)
            Positioned(
              top: 7.h, // Isse icon thora sa box se bahar float karega
              child: Image.asset(
                  'assets/png/locations.png',
                  height: 10.h,
                  fit: BoxFit.contain
              ),
            ),
          ],
        ),
      ),
    );
  }
// ✅ Second Dialog: Notification
  void _showNotificationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 6.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 1.h),
                // Notification Icon
                Image.asset(
                    'assets/icon/dailboxlogo2.png',
                    height: 12.h,
                    fit: BoxFit.contain
                ),
                SizedBox(height: 2.h),
                customText(
                  text: "Notification",
                  fontSize: 20.sp,
                  color: black1,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 1.5.h),
                customText(
                  text: "Please enable notifications to receive updates and reminders",
                  fontSize: 16.sp,
                  color: black2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 4.h),

                // Turn On Button
                CustomButton(
                  borderRadius: BorderRadius.circular(40),
                  text: "Turn on",
                  btnTextColor: whiteColor,
                  fontWeight: FontWeight.bold,
                  height: 6.h,
                  width: double.infinity,
                  onTap: () {
                    Get.back();
                    // Add your notification permission logic here
                  },
                  gradientColor: LinearGradient(
                    colors: [Color(0xFF00BBFF), Color(0xFF26AFE9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                SizedBox(height: 1.5.h),

                // Skip Button
                CustomButton(
                  borderRadius: BorderRadius.circular(40),
                  text: "Skip for now",
                  btnTextColor: blackColor,
                  borderColor: blackColor,
                  height: 6.h,
                  width: double.infinity,
                  btnColor: whiteColor,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBody: true,
    // ya apna page color
        // ⭐ floating effect ke liye


        body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              child: Column(
                children: [

                  Profile('assets/icon/profile.png', "Tony"),
                  SizedBox(height: 1.h),
                  Stack(
                    children: [
                      Row(
                        children: [
                          customText(
                            text: "Top picks this week",
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "SF Pro",
                            color: fullblackd,
                          ),
                          SizedBox(width: 35.w),
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
                        right: 4,
                        bottom: 2,
                        top: 0,
                        child: Image.asset(
                          'assets/icon/forwardlogo.png',
                          height: 3.1.h,
                          width: 6.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 94.w,
                          child: DiscountCard(imagePath: 'assets/png/containimg.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: customText(
                        text: "Quick categories",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SF Pro",
                        color: fullblackd,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.2.h),
                  Row(
                    children: [
                      SizedBox(width: 1.w),
                      Container(
                        width: 9.5.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: whiteColors,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: otpscreenblack1, width: 1),
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/icon/feature.png',
                            height: 3.5.h,
                            width: 3.5.w,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.2.w),
                      ...["Food", "Activities", "Nightlife"].asMap().entries.map((entry) {
                        int idx = entry.key;
                        String text = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Obx(() => GestureDetector(
                            onTap: () => controller.selectCategory(idx),
                            child: Container(
                              width: 25.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == idx
                                    ? Color(0xFF468DC7)
                                    : whiteColors,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: lightBlack, width: 0.2),
                              ),
                              child: Center(
                                child: customText(
                                  text: text,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Inter",
                                  color: controller.selectedIndex.value == idx ? whiteColors : fullblackd,
                                ),
                              ),
                            ),
                          )),
                        );
                      }).toList(),
                    ],
                  ),

                  Obx(() {
                    // Loader
                    if (productController.isLoading.value &&
                        productController.allPromotedProducts.isEmpty) {
                      return SizedBox(
                        height: 30.h,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    // Empty state
                    if (productController.allPromotedProducts.isEmpty) {
                      return SizedBox(
                        height: 30.h,
                        child: const Center(
                          child: Text("No Products Found"),
                        ),
                      );
                    }

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
                        child: SizedBox(
                          height: 30.h,
                          child: PageView.builder(
                            controller: pageController,
                            padEnds: false, // 👈 LEFT SPACE FIX
                            itemCount: productController.allPromotedProducts.length,
                            onPageChanged: (index) {
                              currentIndexNotifier.value = index;
                            },
                            itemBuilder: (context, index) {
                              final item =
                              productController.allPromotedProducts[index];

                              return Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: SizedBox(
                                  width: 40.w,
                                  child: Card(
                                    index: index,
                                    imagePath: item.coverImage ?? "",
                                    name: item.title ?? "No Title",
                                    area: 'las vegas',
                                    product: item,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  }),




                  ValueListenableBuilder<int>(
                    valueListenable: currentIndexNotifier,
                    builder: (context, currentIndex, _) {
                      return Column(
                        children: [
                          // Aapka Slider ya Image yahan hogi



                          // Tab Indicators yahan call karein
                          tabIndicators(currentIndex),

                          SizedBox(height: 1.h),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: customText(
                        text: "Shop Local",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "SF Pro",
                        color: fullblackd,
                      ),
                    ),
                  ),
                  SizedBox(height: 1.2.h),

                  SizedBox(
                    height: 22.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      itemCount: shopLocalController.nearbyOffers.length,
                      // Bilkul mamuli gap ke liye
                      separatorBuilder: (_, __) => SizedBox(width: 1),
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> offer = shopLocalController.nearbyOffers[index];

                        // SizedBox hata kar check karein agar card khud apni width manage kar raha hai
                        return searchCard(
                          imagePath: offer["image1"] ?? "",
                          name: offer["name"] ?? "No Name",
                          location: offer["location"] ?? "No Location",
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: Stack(
                      children: [
                        Row(
                          children: [
                            customText(
                              text: "Local Services",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "SF Pro",
                              color: fullblackd,
                            ),
                            SizedBox(width: 42.w),
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
                          right: -7,
                          top: 0,
                          bottom: 1,
                          child: Center(
                            child: Image.asset(
                              'assets/icon/forwardlogo.png',
                              height: 3.1.h,
                              width: 6.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),



                  Align(
                    alignment: Alignment.topLeft, // Isse top-left se start hoga
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: SizedBox(
                        height: 72.h,
                        child: Obx(() {
                          if (productController.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (productController.allProducts.isEmpty) {
                            return const Center(child: Text("No products available"));
                          }

                          return GridView.builder(
                            padding: EdgeInsets.zero, // ✅ STEP 1: Default padding khatam karein
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: productController.allProducts.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 2.h,
                              crossAxisSpacing: 2.w,
                              mainAxisExtent: 25.h,
                            ),
                            itemBuilder: (context, index) {
                              final product = productController.allProducts[index];

                              return verticalCardStack(
                                imagePath: product.coverImage ?? 'assets/png/placeholder.png',
                                name: product.title ?? "No Name",
                                price: "\$${product.price}",
                              );
                            },
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          // Fixed Bottom Navigation

        ],
      ),

    );
  }
}



Widget verticalCardStack({
  required String imagePath,
  required String name,
  required String price,
}) {
  return GestureDetector(
    onTap: () {
      debugPrint("Clicked on $name");
    },
    child: Container(
      width: 45.w,
      height: 35.h, // adjust as needed
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(25),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 23.5,
            spreadRadius: -5,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child:Stack(
        children: [
          // Card background and image
          // Padding ke andar Image ko ClipPath se wrap karein
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: ClipPath(
                clipper: HeartCutoutClipper(), // Humara naya clipper
                child: Image.network(
                  imagePath,
                  height: 15.h,
                  width: 40.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Top icon inside a container
          Positioned(
            top: 1.2.h,
            right: 2.w,
            child: Container(
              height: 3.8.h,
              width: 8.5.w,
              decoration: BoxDecoration(
                color: whiteColors,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/png/hearts.png',
                  height: 5.h,
                  width: 5.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Name text positioned manually
          Positioned(
            top: 17.h, // adjust as needed
            left: 4.w,
            child: customText(
              text: name,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
              color: whiteColors,
            ),
          ),

          // Price text positioned manually
          Positioned(
            top: 21.h, // adjust as needed
            left: 4.w,
            child: customText(
              text: price,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              fontFamily: "SF Pro",
              color: whiteColors,
            ),
          ),
          Positioned(
            top: 19.5.h,
            right: 3.w,
            child: Container(
              height: 4.h,
              width: 10.w,
              decoration: BoxDecoration(
                color:  otpscreenblue,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: Image.asset(
                  'assets/icon/arrow.png',
                  height: 7.h,
                  width: 6.w,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),

    ),
  );
}

Widget Card({
  required int index,

  required ProductData product, // Pura model yahan pass karein

  required String imagePath,
  required String name,
  required String area,
}) {
  return  GestureDetector(
    onTap: () {
      // Ab aap direct product.id use kar sakte hain
      Get.toNamed(
        '/ProductDetail',
        arguments: product.id,
      );
      print("Sending ID: ${product.id}");
    },
    child: Container(
      width: 45.w,
      height: 30.h, // adjust as per your card size
      decoration: BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 23.5,
            spreadRadius: -5,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Top Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                imagePath,
                height: 18.5.h,
                width: 45.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Name Text
          Positioned(
            top: 20.h,
            left: 3.w,
            child: customText(
              text: name,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "SF Pro",
              color: whiteColors,
            ),
          ),

          // Row of 4 icons
          Positioned(
            top: 21.2.h,
            left: 3.w,
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

          // Bottom-left location icon + area text
          Positioned(
            bottom: 1.h,
            left: 3.w,
            child: Row(
              children: [
                Image.asset(
                  'assets/png/locationlogo.png',
                  height: 4.h,
                  width: 4.w,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 2.w),
                customText(
                  text: area,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "SF Pro",
                  color: whiteColors,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


class DiscountCard extends StatelessWidget {
  final String imagePath;

  const DiscountCard({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 19.6.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: navyblue,
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
                text: "Get Special Discounts",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Nunito",
                color: whiteColors,
              ),
              customText(
                text: "Up to 50%",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Nunito",
                color: whiteColors,
              ),
              SizedBox(height: 4.h),

              GestureDetector(
                onTap: () {
                  print("Claim tapped");
                },
                child: Container(
                  height: 4.h,
                  width: 26.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: lightblu,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: otpscreenblack1,
                      width: 1.3,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: customText(text:
                    "View",

                      color: whiteColors,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Nunito",
                    ),
                  ),
                ),

            ],

          ),
        ),

      ],
    );
  }
}

// ----------------- Profile Widget -----------------
Widget Profile(String? image, String? name, {String weather = "28°"}) {
  final prefs = SharedPreferencesMethod.storage;
  final username = prefs.getString(LocalDBKeys.USERFULLNAME) ?? "User"; // Null safety

  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // 1. Profile Image
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          image!,
          width: 13.w,
          height: 6.h,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(width: 1.5.w),

      // 2. Text Section (WELCOME BACK + USERNAME)
      // Expanded lagane se ye bachi hui jagah mein rahega aur pixel nahi pharega
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text.rich se text auto-wrap (next line) ho jayega
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Welcome Back ",
                    style: TextStyle(
                      fontSize: 15.sp, // Thoda adjust kiya takay screen pe fit aaye
                      fontWeight: FontWeight.w600,
                      fontFamily: "SF Pro",
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text:username ,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "SF Pro",
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            customText(
              text: "Ready for the weekend?",
              fontSize: 14.sp,
              fontFamily: "SF Pro",
              color: Colors.brown,
            ),
          ],
        ),
      ),

      // 3. Weather Section
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Get.toNamed('/WeatherPage'),
              child: Image.asset(
                'assets/png/weather.png',
                height: 4.h,
                width: 8.w,
                fit: BoxFit.contain,
              ),
            ),
            customText(
              text: weather,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              fontFamily: "SF Pro",
              color: const Color(0xAD000000),
            ),
          ],
        ),
      ),

      // 4. Notification Bell
      Container(
        width: 12.w,
        height: 5.5.h,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFE6E6E6)),
        ),
        child: Center(
          child: Image.asset(
            'assets/icon/bellnotification.png',
            height: 2.5.h,
            width: 5.w,
            fit: BoxFit.contain,
          ),
        ),
      ),
    ],
  );
}