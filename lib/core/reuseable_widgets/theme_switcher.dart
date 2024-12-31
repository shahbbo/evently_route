import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../recources/app_colors.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcher();
}

class _ThemeSwitcher extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    bool isLight = themeProvider.appTheme == ThemeMode.light;
    return Container(
      height: 45,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: AppColors.primaryColorLight,
              width: 3
          )
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: (){
              themeProvider.changeAppTheme(false);
            },
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isLight ? AppColors.primaryColorLight : AppColors.transparent,
                ),
                child: Icon(Icons.wb_sunny_outlined, color: isLight ? AppColors.white : AppColors.primaryColorLight,)),
            ),
          SizedBox(width: 14,),
          GestureDetector(
            onTap: (){
              themeProvider.changeAppTheme(true);
            },
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: isLight ? AppColors.transparent : AppColors.primaryColorLight,
                ),
                child: Icon(Icons.mode_night_rounded, color: isLight ? AppColors.primaryColorLight : AppColors.white,
                )
            ),
          ),
        ],
      ),
    );
  }
}
