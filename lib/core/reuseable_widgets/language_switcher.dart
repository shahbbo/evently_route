import 'package:event_planning_app/core/network/local/cache_helper.dart';
import 'package:event_planning_app/features/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../recources/app_colors.dart';
import '../recources/assets_manager.dart';

class LanguageSwitcher extends StatefulWidget {
  const LanguageSwitcher({super.key});

  @override
  State<LanguageSwitcher> createState() => _LanguageSwitcherState();
}

class _LanguageSwitcherState extends State<LanguageSwitcher> {
  @override
  Widget build(BuildContext context) {
    AppLanguageProvider languageProvider = Provider.of<AppLanguageProvider>(context);
    bool isArabic = languageProvider.appLanguage == 'ar';
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
              languageProvider.changeAppLanguage('en');
              CacheHelper.saveData(key: 'language', value: true);
            },
            child: Container(
                height: 40,
                width: 40,
                decoration: !isArabic ? BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: AppColors.primaryColorLight,
                        width: 3
                    )
                ): null,
                child: SvgPicture.asset(AssetsManager.usIcon,
                  fit: BoxFit.fill,)),
          ),
          SizedBox(width: 14,),
          GestureDetector(
            onTap: (){
              languageProvider.changeAppLanguage('ar');
              CacheHelper.saveData(key: 'language', value: false);
            },
            child: Container(
                height: 40,
                width: 40,
                decoration: isArabic ? BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: AppColors.primaryColorLight,
                        width: 3
                    )
                ): null,
                child: SvgPicture.asset(AssetsManager.egIcon,
                  fit: BoxFit.fill,)),
          ),
        ],
      ),
    );
  }
}
