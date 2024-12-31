
import 'package:event_planning_app/core/recources/app_colors.dart';
import 'package:event_planning_app/core/recources/app_styles.dart';
import 'package:event_planning_app/core/reuseable_widgets/custom_button.dart';
import 'package:event_planning_app/core/reuseable_widgets/language_switcher.dart';
import 'package:event_planning_app/core/reuseable_widgets/theme_switcher.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/recources/assets_manager.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({super.key});

  static const routeName = '/onBoarding1';

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * .03,
            ),
            SvgPicture.asset(AssetsManager.eventlyLogo,),
            SizedBox(
              height: height * .02,
            ),
            SvgPicture.asset(AssetsManager.onBording1),
            SizedBox(
              height: height * .02,
            ),
            Text(
              AppLocalizations.of(context)!.onBT1,
              style: AppStyle.primary20bold,
            ),
            SizedBox(
              height: height * .02,
            ),
            Text(
              AppLocalizations.of(context)!.onBST1,
              style: AppStyle.black16medium.copyWith(
                color: themeProvider.appTheme == ThemeMode.light ? Colors.black : Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: AppStyle.primary20bold.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                LanguageSwitcher(),
              ],

            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: AppStyle.primary20bold.copyWith(
                    color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                ThemeSwitcher(),
              ],

            ),
            SizedBox(
              height: height * .03,
            ),
            CustomButton(
                onTap: () {
                  Navigator.pushNamed(context, '/onBoarding2');
                },
                buttonColor: AppColors.primaryColorLight,
                buttonName: AppLocalizations.of(context)!.letsStart,
                textColor: AppColors.white,
                borderColor: AppColors.primaryColorLight),
          ],
        ),
      ),
    );
  }
}
