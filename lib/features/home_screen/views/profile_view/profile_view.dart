import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/recources/app_colors.dart';
import '../../../../core/recources/app_styles.dart';
import '../../../../core/recources/assets_manager.dart';
import '../../../auth/presentation/pages/login_screen.dart';
import '../../../provider/language_provider.dart';
import '../../../provider/theme_provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.25,
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(65),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.04),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: AssetImage(AssetsManager.routeLogo)),
                      SizedBox(
                        width: width * .03,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mahmoud Shahbo',
                              style: AppStyle.white24bold,
                            ),
                            Text(
                              overflow: TextOverflow.fade,
                              "m.shahbbo@gmail.com",
                              style: AppStyle.white16medium,
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: themeProvider.appTheme == ThemeMode.dark
                      ? AppStyle.black20w500.copyWith(color: AppColors.white)
                      : AppStyle.black20w500,),
                SizedBox(height: height * 0.02),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryColorLight,
                      width: 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: languageProvider.appLanguage,
                      isExpanded: true,
                      dropdownColor: themeProvider.appTheme == ThemeMode.dark
                          ? AppColors.primaryColorDark
                          : AppColors.bglight,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.primaryColorLight,
                        size: 35,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            AppLocalizations.of(context)!.english,
                            style: AppStyle.black20w500
                                .copyWith(color: AppColors.primaryColorLight),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text(
                            AppLocalizations.of(context)!.arabic,
                            style: AppStyle.black20w500
                                .copyWith(color: AppColors.primaryColorLight),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          languageProvider.changeAppLanguage(value!);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: themeProvider.appTheme == ThemeMode.dark
                      ? AppStyle.black20w500.copyWith(color: AppColors.white)
                      : AppStyle.black20w500,
                ),
                SizedBox(height: height * 0.02),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primaryColorLight,
                      width: 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: themeProvider.appTheme == ThemeMode.dark
                          ? 'dark'
                          : 'light',
                      isExpanded: true,
                      dropdownColor: themeProvider.appTheme == ThemeMode.dark
                          ? AppColors.primaryColorDark
                          : AppColors.bglight,
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.primaryColorLight,
                        size: 35,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'light',
                          child: Text(
                            AppLocalizations.of(context)!.light,
                            style: AppStyle.black20w500
                                .copyWith(color: AppColors.primaryColorLight),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'dark',
                          child: Text(
                            AppLocalizations.of(context)!.dark,
                            style: AppStyle.black20w500
                                .copyWith(color: AppColors.primaryColorLight),
                          ),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          themeProvider.changeAppTheme(
                              value == 'dark' ? true : false);
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: height * 0.15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, LoginScreen.routeName);
                  },
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16))),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(16)),
                    // shape: WidgetStatePropertyAll(),
                    backgroundColor: WidgetStatePropertyAll(AppColors.red),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.login_outlined,
                        color: AppColors.white,
                      ),
                      Text(
                        AppLocalizations.of(context)!.log_out,
                        style: AppStyle.white20medium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}