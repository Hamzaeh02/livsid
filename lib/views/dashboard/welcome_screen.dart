import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livsd/outh_file/local_db_key.dart';
import 'package:livsd/utils/shared_prefrences_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../components/custom_button.dart';
import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/welcome_controller.dart';
import '../../widgets/custom_bottom_navigation.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();

}
final WelcomeController controller = Get.put(WelcomeController());


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
                color: Colors.white,
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
                    btnTextColor: Colors.white,
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
                    btnTextColor: Colors.black,
                    borderColor: Colors.black,
                    height: 6.h,
                    width: double.infinity,
                    btnColor: Colors.white,
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
                  btnTextColor: Colors.white,
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
                  btnTextColor: Colors.black,
                  borderColor: Colors.black,
                  height: 6.h,
                  width: double.infinity,
                  btnColor: Colors.white,
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
    final List<Map<String, String>> productList = [
      {
        'name': 'Breakfast Republic',
        'image': 'assets/png/foods.png',
        'area': 'Scripps Ranch',
      },
      {
        'name': 'Tacos El Gordo',
        'image': 'assets/png/food4.png',
        'area': 'National City',
      },
    ];
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
                        right: 1,
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
                                border: Border.all(color: otpscreenblack1, width: 1),
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

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 1.w),
                      child: SizedBox(
                        height: 33.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(productList.length, (index) {
                              final item = productList[index];
                              return Padding(
                                padding: EdgeInsets.only(right: 2.w),
                                child: Card(
                                  index: index,
                                  productList: productList,
                                  imagePath: item['image']!,
                                  name: item['name']!,
                                  area: item['area']!,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
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
                          right: -8,
                          top: 0,
                          bottom: 1,
                          child: Center(
                            child: Image.asset(
                              'assets/icon/forwardlogo.png',
                              height: 4.h,
                              width: 6.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),



                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.w),
                      child: SizedBox(
                        height: 72.h,
                        child: Column(
                          children: [
                            // Row 1
                            SizedBox(
                              height: 25.h,
                              child: Row(
                                children: [
                                  verticalCardStack(
                                    imagePath: 'assets/png/oilchanges.png',
                                    name: "Synthetic oil change",
                                    price: "\$110.00",
                                  ),
                                  SizedBox(width: 2.w),
                                  verticalCardStack(
                                    imagePath: 'assets/png/eyelash.png',
                                    name: "Full lash set",
                                    price: "\$99.00",
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2.h),
                            // Row 2
                            SizedBox(
                              height: 25.h,
                              child: Row(
                                children: [
                                  verticalCardStack(
                                    imagePath: 'assets/png/oilchanges.png',
                                    name: "Brake service",
                                    price: "\$150.00",
                                  ),
                                  SizedBox(width: 2.w),
                                  verticalCardStack(
                                    imagePath: 'assets/png/eyelash.png',
                                    name: "Car wash premium",
                                    price: "\$45.00",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                imagePath,
                height: 15.h,
                width: 40.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Top icon inside a container
          Positioned(
            top: 1.5.h,
            right: 2.w,
            child: Container(
              height: 3.8.h,
              width: 8.w,
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
            top: 20.h,
            right: 2.w,
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
  required List productList,
  required String imagePath,
  required String name,
  required String area,
}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(
        '/ProductDetail',

      );

    },
    child: Container(
      width: 45.w,
      height: 35.h, // adjust as per your card size
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
              child: Image.asset(
                imagePath,
                height: 20.h,
                width: 45.w,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Name Text
          Positioned(
            top: 21.h,
            left: 2.w,
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
            top: 23.h,
            left: 2.w,
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
            left: 2.w,
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