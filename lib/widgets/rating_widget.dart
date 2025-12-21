import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class StarRating extends StatelessWidget {
  final double rating; // 0 to 5
  final double starSize;
  final Color filledColor;
  final Color unfilledColor;

  const StarRating({
    Key? key,
    required this.rating,
    this.starSize = 16,
    this.filledColor = Colors.amber,
    this.unfilledColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        if (rating >= index + 1) {
          // full star
          return Icon(Icons.star, color: filledColor, size: starSize.sp);
        } else if (rating > index && rating < index + 1) {
          // half star
          return Icon(Icons.star_half, color: filledColor, size: starSize.sp);
        } else {
          // empty star
          return Icon(Icons.star_border, color: unfilledColor, size: starSize.sp);
        }
      }),
    );
  }
}
