import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.textInputAction = TextInputAction.next,
    this.maxLines,
    this.minLines,
    this.hintText,
    this.hintStyle,
    this.keyboaredtype,
    this.prefix,
    this.prefixConstraints,
    this.suffixIcon,
    this.suffixConstraints,
    this.validator,
    this.readOnly,
    this.labelText,
    this.maxLength,
    this.autofocus = false,
    this.isRequiredClear = false,
    this.inputFormatter,
    this.onChanged,
    this.onTap,
    this.textAlign,
    this.textAlignVertical,
    this.height,
    this.borderRadius,
    this.borderSide,
    this.prefixIcon,
  });

  final double? width;
  final double? height;
  final bool? readOnly;
  final EdgeInsetsGeometry? margin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? isObscureText;
  final bool isRequiredClear;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixConstraints;
  dynamic validator;
  final TextInputType? keyboaredtype;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatter;
  void Function(String)? onChanged;
  final TextAlign? textAlign;
  final VoidCallback? onTap;
  final TextAlignVertical? textAlignVertical;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        width: width,
        margin: margin,
        child: TextFormField(
          enableSuggestions: true,
          smartDashesType: SmartDashesType.enabled,
          autocorrect: true,
          autofocus: autofocus,
          style: const TextStyle(
            color: Colors.black54, // Dark text color
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          keyboardType: keyboaredtype ?? TextInputType.emailAddress,
          controller: controller,
          focusNode: focusNode,
          obscureText: isObscureText!,
          textInputAction: textInputAction,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          readOnly: readOnly ?? false,
          decoration: _buildDecoration(),
          validator: validator,
          maxLength: maxLength,
          onTap: onTap,
          inputFormatters: inputFormatter,
          onChanged: onChanged ?? (v) {},
          textAlign: textAlign ?? TextAlign.start,
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
        ),
      ),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: hintStyle ?? const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: Colors.black45,
      ),
      labelText: labelText,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Colors.black45,
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 16,
      ),
      filled: true,
      fillColor: Colors.grey.shade100, // Light grey background
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30), // Rounded corners
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none, // No border when focused
      ),
      prefixIcon: prefixIcon, // ✅ Ensure the prefix icon is included
      suffixIcon: suffixIcon, // ✅ Also ensure suffix icon if needed
    );
  }


}
