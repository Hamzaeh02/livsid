import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constants/color_constants.dart';
import '../../constants/constants_widgets.dart';
import '../../controllers/search_controller.dart';
import '../../controllers/welcome_controller.dart';
import '../../widgets/rating_widget.dart' show StarRating;



class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final WelcomeControllers controller = Get.put(WelcomeControllers());
  final TextEditingController searchController = TextEditingController();

  final List<String> filters = [
    "Most relevant",
    "Low price",
    "Deal",
    "Nightlife",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LOGO

              SizedBox(height: 1.h),


              SizedBox(height: 1.h),

              /// SEARCH FIELD
              Container(
                height: 5.5.h,
                padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    SizedBox(width: 2.w),
                    Image.asset(
                      'assets/png/searchicon.png',
                      height: 24,
                      width: 24,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: TextField(
                        onChanged: controller.onSearchChanged,
                        controller: searchController,
                        onTap: () {
                          controller.setShowHistory(true); // Show history on tap
                        },
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontFamily: "SF Pro",
                        ),
                        cursorColor: Colors.white,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          controller.executeSearch(value);
                          controller.setShowHistory(false); // hide history
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search for food, events, services & more",
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white54,
                            fontFamily: "SF Pro",
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 0.7.h,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        searchController.clear();
                        controller.clearSearch();
                        controller.setShowHistory(false);
                      },
                      child: Container(
                        height: 3.8.h,
                        width: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/png/filter.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),

              /// FILTERS
              Obx(() {
                // condition yahan lagao
                if (controller.isSearching.value) {
                  return const SizedBox(); // search ho rahi hai → filters hide
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(filters.length, (index) {
                      final isSelected =
                          controller.selectedIndex.value == index;

                      return Padding(
                        padding: EdgeInsets.only(right: 2.w),
                        child: GestureDetector(
                          onTap: () {
                            controller.selectCategory(index);
                            searchController.clear();
                            controller.setShowHistory(false);
                          },
                          child: Container(
                            height: 4.5.h,
                            padding: EdgeInsets.symmetric(horizontal: 4.2.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF468DC7)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black12),
                            ),
                            child: Center(
                              child: customText(
                                text: filters[index],
                                fontSize: 14.sp,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),

              SizedBox(height: 2.h),

              /// DYNAMIC CONTENT
              Obx(() {
                onChanged: controller.onSearchChanged ;

                // 1️⃣ Show search history only if search bar tapped
                if (controller.showHistory.value &&
                    controller.previousSearches.isNotEmpty) {


                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ...controller.previousSearches.reversed.map((search) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                        'assets/png/watch.png',
                          height: 24,
                          width: 24,
                        ),
                              title: customText(
                                text: search,
                                fontSize: 16.sp,fontWeight: FontWeight.w400,
                                color: fullblack,
                              ),
                              onTap: () {
                                controller.executeSearch(search);
                                searchController.text = search;
                                controller.setShowHistory(false);
                              },
                            ),
                            Divider(
                              color: Colors.grey, // Divider color
                              thickness: 0.5,    // Thickness
                              height: 0,         // Space around divider
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                }



                // 2️⃣ Show search results
                else if (controller.currentQuery.value.isNotEmpty) {
                  if (controller.filteredOffers.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            customText(
                              text: "Result for: ",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            SizedBox(width: 1.w),
                            customText(
                              text: controller.currentQuery.value,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 1.h),
                        ...controller.filteredOffers.map(
                              (offer) => searchcardone(
                            imagePath1: offer["image1"]!,
                            imagePath2: offer["image2"]!,
                            imagePath3: offer["image3"]!,
                            rating: offer["rating"]!,
                            name: offer["name"]!,
                            location: offer["location"]!,
                            time: offer["time"]!,
                            discription: offer["description"]!,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            customText(
                              text: "Result for: ",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            SizedBox(width: 1.w),
                            customText(
                              text: controller.currentQuery.value,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                        SizedBox(height: 3.h),
                        Center(
                          child: Image.asset(
                            'assets/png/notfound.png',
                            height: 32.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Center(
                          child: customText(
                            text: "Oops! We couldn’t find that.",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    );
                  }
                }

                // 3️⃣ Default Most Relevant / Nearby Offers
                else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customText(
                        text: "Location",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          Image.asset(
                            'assets/png/locationicon.png',
                            height: 18,
                            width: 18,
                          ),
                          SizedBox(width: 1.w),
                          customText(
                            text: "San Diego, CA",
                            fontSize: 16.sp,
                            color: Colors.black,
                          ),
                          SizedBox(width: 1.w),
                          Image.asset(
                            'assets/png/downarrow.png',
                            height: 16,
                            width: 16,
                          ),
                        ],
                      ),
                      SizedBox(height: 2.5.h),
                      customText(
                        text: "Popular Searches",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      SizedBox(height: 2.h),
                      SizedBox(
                        height: 23.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.nearbyOffers.length,
                          separatorBuilder: (_, __) => SizedBox(width: 2.w),
                          itemBuilder: (context, index) {
                            final offer = controller.nearbyOffers[index];
                            return searchCard(
                              imagePath: offer["image1"],
                              name: offer["name"],
                              location: offer["location"],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 2.h),
                      customText(
                        text: "Nearby Offers",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      SizedBox(height: 1.h),
                      ...controller.filteredOffers.map(
                            (offer) => searchcardone(
                          imagePath1: offer["image1"]!,
                          imagePath2: offer["image2"]!,
                          imagePath3: offer["image3"]!,
                          rating: offer["rating"]!,
                          name: offer["name"]!,
                          location: offer["location"]!,
                          time: offer["time"]!,
                          discription: offer["description"]!,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}









Widget searchcardone({
  required String imagePath1,
  required String imagePath2,
  required String imagePath3,
  required String rating, required String name,required String location,required String time,required String discription,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 IMAGES STACK
        SizedBox(
          height: 21.h,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imagePath1,
                    width: 45.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              /// ⭐ RATING
              Positioned(
                top: 2.h,
                left: 4.w,
                child: Container(
                  height: 2.5.h,
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: const Color(0x66FFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: whiteColors, width: 0.2),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/png/Star.png",
                        width: 4.w,
                      ),
                      SizedBox(width: 1.w),
                      customText(
                        text: rating,
                        fontSize: 12.sp,
                        color: whiteColors,
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                right: 0,
                top: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imagePath2,
                    width: 37.w,
                    height: 10.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                right: 0,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    imagePath3,
                    width: 37.w,
                    height: 10.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 1.h),

        /// 🔹 TITLE (NOW SCROLLABLE)
        customText(
          text: name,
          fontFamily: "Montserrat",
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: fullblack,
        ),
        Row(
          children: [
            Image.asset(
              'assets/png/locationpng.png',
              height: 3.h,
              width: 3.w,

            ),
            SizedBox(width: 2.w),
            customText(
              text:location,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Montserrat",
              color: slateGray,


            ),
            SizedBox(width: 7.w),
            Container(
              height: 0.9.h,
              width: 0.9.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color:  Color(0xFFFFC107),
              ),
            ),
            SizedBox(width: 1.w),
            customText(
              text:time,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Montserrat",
              color: applegreen,
            ),
          ],
        ),
        RichText(
          text: TextSpan(
            text: discription + " ", // normal text
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Montserrat",
              color: fullblack,
            ),
            children: [
              TextSpan(
                text: "Read more",
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Montserrat",
                  color: steelblue, // blue color for read more
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.5.h),
        Container(
          width: double.infinity,   // full width
          height: 0.2.h,           // responsive height
          color: steelblue,       // divider color, change as needed
        ),
        SizedBox(height: 1.5.h),



      ],
    ),
  );
}



/// =====================
/// SEARCH CARD
/// =====================
Widget searchCard({
  required String imagePath,
  required String name,
  required String location,
}) {
  return SizedBox(
    width: 70.w,
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            height: 22.h,
            width: 70.w,
            fit: BoxFit.cover,
          ),
        ),

        /// TITLE
        Positioned(
          top: 3.h,
          left: 7.w,
          child: customText(
            text: name,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: whiteColors,
          ),
        ),

        /// LOCATION CHIP
        Positioned(
          bottom: 2.h,
          left: 7.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            height: 4.h,
            decoration: BoxDecoration(
              color: fullblack,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/png/locationicon.png',
                  height: 16,
                  width: 16,
                  color: otpscreenblue,
                ),
                SizedBox(width: 1.w),
                customText(
                  text: location,
                  fontSize: 13.sp,
                  color: whiteColors,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
