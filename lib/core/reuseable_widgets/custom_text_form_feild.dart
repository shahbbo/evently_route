import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recources/app_colors.dart';
import '../recources/app_styles.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final Color borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final int? numLines;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  final VoidCallback? onTap;


  const CustomTextFormField({
    super.key,
    required this.borderColor,
    this.hintText,
    this.numLines,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.onTap, this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText ?? false,
      obscuringCharacter: '*',
      controller: controller,
      onTap: onTap,
      maxLines: numLines ?? 1,
      style: AppStyle.primary14bold.copyWith(
        color: themeProvider.appTheme == ThemeMode.light
            ? AppColors.gray
            : AppColors.white,
      ),
      cursorColor: borderColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintStyle: AppStyle.primary14bold.copyWith(
            color: themeProvider.appTheme == ThemeMode.light
                ? AppColors.gray
                : AppColors.white),
        hintText: hintText,
      ),
      // onSaved: (value) {
      //   controller!.text = value!;
      // },
      // onFieldSubmitted: (value) {
      //   controller!.text = value;
      // },
      // onChanged: (value) {
      //   controller!.text = value;
      // },
      validator: validator,
    );
  }
}
