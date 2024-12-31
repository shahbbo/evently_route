import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/recources/app_colors.dart';
import '../../../../core/recources/app_styles.dart';
import '../../../../core/recources/assets_manager.dart';
import '../../../../core/reuseable_widgets/custom_button.dart';
import '../../../../core/reuseable_widgets/custom_text_form_feild.dart';
import '../../../../core/reuseable_widgets/language_switcher.dart';
import 'create_account.dart';


class ForgetPassword extends StatelessWidget {
  static const String routeName = 'forgetPassword';
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: AppColors.transparent,
        title: Text( AppLocalizations.of(context)!.forget_password,style: AppStyle.white20medium.copyWith(
          color: AppColors.black
        ),),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * .015,
              ),
              Image(image: AssetImage(AssetsManager.forgetPassword),fit: BoxFit.fill,),
              SizedBox(
                height: height * .02,
              ),
              CustomTextFormField(
                borderColor: AppColors.gray,
                hintText: AppLocalizations.of(context)!.email,
                controller: null,
                prefixIcon: Icon(Icons.email,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomButton(
                onTap: (){
                  Navigator.pushReplacementNamed(context, CreateAccount.routeName);
                },
                buttonColor: AppColors.primaryColorLight,
                buttonName: AppLocalizations.of(context)!.reset_password,
                textColor: AppColors.white,
                borderColor: AppColors.primaryColorLight,
              ),
              SizedBox(
                height: height * .04,
              ),
              LanguageSwitcher(),
            ],
          ),
        ),
      ),

    );
  }
}
