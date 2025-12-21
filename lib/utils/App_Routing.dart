import 'package:get/get.dart';
import 'package:livsd/views/auth_screens/login.dart';
import 'package:livsd/views/auth_screens/otp_input_screen.dart';
import 'package:livsd/views/auth_screens/signup.dart';
import 'package:livsd/views/auth_screens/sucess_screen.dart';
import 'package:livsd/views/auth_screens/verification_code_screen.dart';
import 'package:livsd/views/dashboard/product_detail.dart';
import 'package:livsd/views/dashboard/product_detail_scroll_view.dart';
import 'package:livsd/views/dashboard/search_screen.dart';
import 'package:livsd/views/dashboard/weather_screen.dart';
import 'package:livsd/views/dashboard/welcome_screen.dart';
import 'package:livsd/views/dashboard/wish_list_screen.dart' hide ProductDetailPage;
import 'package:livsd/widgets/custom_bottom_navigation.dart' hide SearchScreen;


import '../views/auth_screens/splash_screen.dart';
import '../views/dashboard/main_screen.dart';
class AppRoutes {
  static List<GetPage<dynamic>> routes = [
    GetPage(name: '/', page: () =>  SplashScreen()),
    GetPage(name: '/Login', page: () =>  LoginScreen()),
    GetPage(name: '/Signup', page: () =>  Signup()),
    GetPage(name: '/Otp', page: () =>  OtpInputScreen()),
    GetPage(name: '/Verification', page: () =>  VerificationCodeScreen()),
    GetPage(name: '/SucessScreen', page: () =>  SucessScreen()),
    GetPage(name: '/WelcomeScreen', page: () =>  WelcomeScreen()),
    // Option 2: Change GetPage name to match navigation
    GetPage(
        name: '/ProductDetail', // capital 'D'
        page: () => ProductDetailWidget2(
            imagepath: 'assets/png/foodimg.png',
            imagepath1: 'assets/png/image1.png',
            imagepath2: 'assets/png/image2.png',
            imagepath3: 'assets/png/image3.png',
            imagepath4: 'assets/png/image4.png',
            name: "Bali Hai Restaurant",
            initialIndex: 1,
            rating: "4.7",
            review: "800 Reviews",
            location: "19 Santa Teresa Blvd"
        )
    ),


    GetPage(name: '/ProductDetailScroll', page: () =>  ProductDetailScrollView()),GetPage(name: '/WeatherPage', page: () =>  WeatherScreen()),

    GetPage(name: '/SearchScreen', page: () =>  SearchScreen()),
    GetPage(name: '/MainScreen', page: () =>  MainScreen()),
    GetPage(name: '/Productdetailpage', page: () =>  ProductDetailWidget(imagepath: 'assets/png/resturantimage.png',imagepath1: 'assets/png/images1.png',imagepath2: 'assets/png/images2.png',imagepath3: 'assets/png/images3.png',imagepath4: 'assets/png/images4.png', name: "Bali Hai Restaurant", initialIndex: 1, rating: "4.7", review: "800 Reviews", location: "19 Santa Teresa Blvd")),

    // GetPage(name: '/login', page: () => const Login()),
    // GetPage(name: '/signUp', page: () =>  signUp()),
    // GetPage(name: '/homepage', page: () =>  HomePage()),
    // GetPage(name: '/mainbottombar', page: () =>  MainBottomBar()),
    // GetPage(name: '/userdashboard', page: () =>  UserDashboard()),
    // GetPage(name: '/universities', page: () =>  Universities()),
    // GetPage(name: '/setting', page: () =>  Setting()),
    // GetPage(name: '/testresult', page: () =>  TestResult()),
    // GetPage(name: '/termandcondition', page: () =>  TermCondition()),
    // GetPage(name: '/Faq', page: () =>  Faq()),
    // GetPage(name: '/contactus', page: () =>  ContactUs()),
    // GetPage(name: '/bookingroom', page: () =>  BookingRoom()),
    // GetPage(name: '/test', page: () =>  PsycologicalTest()),
    // GetPage(name: '/form', page: () =>  JobForm()),
    // GetPage(name: '/add', page: () => UniversityAdd()),
    // GetPage(name: '/fileupload', page: () => FileUpload()),
    // GetPage(name: '/homerental', page: () => HomeRentalForm()),
    // GetPage(name: '/myhouselisting', page: () => MyHouseListing()),

  ];
}
