class ApiEndPoints{
  // Auth
  static const String signupUser = '/auth/sign-up';
  static const String loginUser = '/auth/sign-in';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resendOtp = '/auth/resend-otp';
  static const String verifyOtp = '/auth/verify-otp';

  static const String moreProductDetail = '/product/many?page=1&limit=10&sort=new';
  static const String getPromotedProducts = '/Product/get/promoted';

  static String productDetail(String productId) {
    return '/product/get/$productId';
  }

}