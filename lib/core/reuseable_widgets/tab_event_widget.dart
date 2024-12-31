import 'package:event_planning_app/core/recources/app_colors.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../recources/app_styles.dart';

class TabEventWidget extends StatelessWidget {
  final String tabName;
  final bool selectedTab;
  final bool isCreateEvent;

  const TabEventWidget({
    super.key,
    required this.selectedTab,
    required this.tabName,
    required this.isCreateEvent,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: height * .05,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 30),
      decoration: BoxDecoration(
          color: isCreateEvent
              ? selectedTab
              ? AppColors.blue
              : AppColors.transparent
              // home screen
              : selectedTab
              ? themeProvider.appTheme == ThemeMode.light ? AppColors.white : AppColors.blue
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isCreateEvent
                  ? !selectedTab
                  ? AppColors.blue
                  : AppColors.transparent
                  // home screen
                  : !selectedTab
                  ? themeProvider.appTheme == ThemeMode.light ? AppColors.white : AppColors.blue
                  : AppColors.transparent,
              width: 2)),
      child: Center(
        child: Text(
          tabName,
          style: selectedTab
              ? AppStyle.primary14medium
                  .copyWith(
              color: isCreateEvent
                  ? themeProvider.appTheme == ThemeMode.light ? AppColors.white : AppColors.primaryColorDark
                  : themeProvider.appTheme == ThemeMode.light ? AppColors.blue : AppColors.white ,
              fontSize: 16)
              : AppStyle.white14medium
                  .copyWith(
              color: isCreateEvent
                  ? AppColors.blue
                  : AppColors.white,
              fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
