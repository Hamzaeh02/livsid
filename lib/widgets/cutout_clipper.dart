import 'package:flutter/cupertino.dart';

class HeartCutoutClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    // 1. Base shape: Poori image ka rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 2. Cutout shape: Iski width ko 32.0 rakha hai (aap 25-30 bhi kar sakte hain)
    double cutoutWidth = 37.0;
    double cutoutHeight = 39.0; // Height bhi thori adjust ki hai balance ke liye

    path.addRRect(RRect.fromLTRBAndCorners(
      size.width - cutoutWidth, // Left position (Size minus width)
      0,                         // Top position
      size.width,                // Right edge tak
      cutoutHeight,              // Bottom position
      bottomLeft: Radius.circular(12), // Sirf bottom-left corner round hoga to behtar lagega
    ));

    // evenOdd rule hole create kar deta hai jahan shapes overlap karti hain
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}