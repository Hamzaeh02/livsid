import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    this.width,
    this.margin,
    required this.text,
    this.height,
    this.fontSize,
    this.btnColor,
    this.borderColor,
    this.btnTextColor,
    this.isLoading = false,
    this.borderRadius,
    this.gradientColor,
    this.icon,
    this.image,
    this.iconSize = 24.0,
    this.imageHeight = 10,
    this.fontWeight,
    this.padding, // Padding parameter defined but not set
    this.fontFamily, // FontFamily parameter added
  });

  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final double? fontSize;
  final bool? isLoading;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  final BorderRadius? borderRadius;
  final Gradient? gradientColor;
  final IconData? icon;
  final String? image;
  final double iconSize;
  final double imageHeight;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: width ?? size.width * 0.4,
        height: height ?? size.height * 0.062,
        decoration: BoxDecoration(
          gradient: gradientColor ??
              LinearGradient(
                colors: [btnColor ?? primaryColor, btnColor ?? primaryColor],
              ),
          borderRadius: borderRadius ?? BorderRadius.circular(50),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Center(
          child: isLoading == true
              ? const SizedBox(
            height: 30,
            width: 30,
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
              : Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (image != null)
                  Image.asset(
                    image!,
                    height: iconSize,
                    width: iconSize,
                    fit: BoxFit.contain,
                  ),
                if (icon != null || image != null)
                  const SizedBox(width: 8),
                customText(
                  text: text,
                  fontFamily: fontFamily,
                  color: btnTextColor ?? Colors.white,
                  fontSize: fontSize ?? 16,
                  fontWeight: fontWeight ?? FontWeight.w400,
                ),
                if (icon != null)
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(
                      icon,
                      size: iconSize,
                      color: btnTextColor ?? Colors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


enum ImageAlignment { left, right }

class RowCustomButton extends StatelessWidget {
  const RowCustomButton({
    super.key,
    this.onTap,
    this.width,
    this.margin,
    required this.text,
    required this.image,
    this.height,
    this.fontSize,
    this.btnColor,
    this.borderColor,
    this.btnTextColor,
    this.isLoading = false,
    this.borderRadius,
    this.gradientColors,
    this.imageHeight = 50,
    this.imageWeight = 40,
    this.imageAlignment = ImageAlignment.left,
    this.fontFamily, // Default to left alignment
  });

  final fontFamily;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final String? image;
  final double? fontSize;
  final bool? isLoading;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  final BorderRadius? borderRadius;
  final List<Color>? gradientColors;
  final double imageHeight;
  final double imageWeight;
  final ImageAlignment imageAlignment;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap ?? () {},
      child: Container(
        width: width ?? size.width * 0.4,
        height: height ?? size.height * 0.062,
        decoration: BoxDecoration(
          gradient: gradientColors != null
              ? LinearGradient(
                  colors: gradientColors!,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: gradientColors == null ? btnColor ?? Colors.white : null,
          borderRadius: borderRadius ?? BorderRadius.circular(50),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: 1,
          ),
        ),
        child: isLoading == true
            ? const SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: _buildChildrenBasedOnAlignment(),
                ),
              ),
      ),
    );
  }

  // Helper method to build the children based on image alignment
  List<Widget> _buildChildrenBasedOnAlignment() {
    if (imageAlignment == ImageAlignment.left) {
      return [
        Image.asset(
          image!,
          height: imageHeight,
          width: imageWeight,
        ),
        const SizedBox(width: 5),
        customText(
          text: text,
          color: btnTextColor ?? Colors.black,
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w500,
        ),
      ];
    } else {
      return [
        customText(
          text: text,
          color: btnTextColor ?? Colors.black,
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(width: 5),
        Image.asset(
          image!,
          height: imageHeight,
          width: imageWeight,
        ),
      ];
    }
  }
}
