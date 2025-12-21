import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_fonts.dart';
import '../utils/color_constants.dart';

TextStyle textStyle = GoogleFonts.montserrat(
  fontSize: 16,
  color: ColorConstant.whiteA700.withOpacity(0.8),
);

class MyText extends StatefulWidget {
  final String title;
  final String? weight;
  final FontWeight? customWeight;
  final double? fontSize, height,letterSpacing;
  final clr;
  final toverflow;
  final bool? center;
  final bool? alignRight;
  final int? line;
  final bool? under, cut, isMontserrat;
  final List<FontFeature>? fontFeatures;

  MyText(
      {required this.title,
      this.fontSize,
      this.clr,
      this.fontFeatures,
      this.weight,
      this.customWeight,
      this.height,
      this.center,
        this.alignRight,
      this.line,
      this.under,
      this.toverflow,
      this.cut,
        this.letterSpacing,
      this.isMontserrat});

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      overflow:
          widget.toverflow == null ? TextOverflow.visible : widget.toverflow,
      maxLines: widget.line,
      textScaleFactor: 1.0,
      style: widget.isMontserrat == false
          ? TextStyle(
          letterSpacing: widget.letterSpacing ?? null,
              fontFamily: AppFonts.lucidaBright,
              height: widget.height,
              decoration: widget.under == true
                  ? TextDecoration.underline
                  : widget.cut == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
              fontSize: widget.fontSize ?? 16,
              color: widget.clr ?? ColorConstant.blackColor,
              fontWeight: widget.customWeight != null
                  ? widget.customWeight
                  : widget.weight == null
                      ? FontWeight.normal
                      : widget.weight == "Bold"
                          ? FontWeight.bold
                          : widget.weight == "Semi Bold"
                              ? FontWeight.w600
                              : FontWeight.normal)
          : GoogleFonts.poppins(
              fontFeatures: widget.fontFeatures,
          letterSpacing: widget.letterSpacing ?? null,
              height: widget.height,
              decoration: widget.under == true
                  ? TextDecoration.underline
                  : widget.cut == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
              fontSize: widget.fontSize ?? 16,
              color: widget.clr ?? ColorConstant.blackColor,
              fontWeight: widget.customWeight != null
                  ? widget.customWeight
                  : widget.weight == null
                      ? FontWeight.normal
                      : widget.weight == "Bold"
                          ? FontWeight.bold
                          : widget.weight == "Semi Bold"
                              ? FontWeight.w600
                              : FontWeight.normal),
      textAlign: widget.center == null ? widget.alignRight != null ? TextAlign.right:
           TextAlign.left
          : widget.center!
              ? TextAlign.center
              : TextAlign.left,
    );
  }
}
