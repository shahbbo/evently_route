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
import '../../../home_screen/home_screen.dart';
import 'login_screen.dart';

class CreateAccount extends StatefulWidget {
  static const String routeName = 'register';
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

bool obscureText = true;

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        forceMaterialTransparency: true,
        title: Text( AppLocalizations.of(context)!.register,style: AppStyle.white20medium.copyWith(
          color: AppColors.black
        ),),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: Column(
            children: [
              SizedBox(
                height: height * .05,
              ),
              Image(image: AssetImage(AssetsManager.logo)),
              SizedBox(
                height: height * .01,
              ),
              CustomTextFormField(
                borderColor: AppColors.gray,
                hintText: AppLocalizations.of(context)!.name,
                controller: null,
                prefixIcon: Icon(Icons.person,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                ),
              ),
              SizedBox(
                height: height * .01,
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
                height: height * .015,
              ),
              CustomTextFormField(
                borderColor: AppColors.gray,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: Icon(Icons.lock,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                ),
                obscureText: obscureText,
                suffixIcon: IconButton(icon: obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },),
          
              ),
              SizedBox(
                height: height * .015,
              ),
              CustomTextFormField(
                borderColor: AppColors.gray,
                hintText: AppLocalizations.of(context)!.re_password,
                prefixIcon: Icon(Icons.lock,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                ),
                obscureText: obscureText,
                suffixIcon: IconButton(icon: obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },),
              ),
              SizedBox(
                height: height * .015,
              ),
              CustomButton(
                onTap: (){
                  Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                },
                buttonColor: AppColors.primaryColorLight,
                buttonName: AppLocalizations.of(context)!.create_account,
                textColor: AppColors.white,
                borderColor: AppColors.primaryColorLight,
              ),
              SizedBox(
                height: height * .015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.have_Account,
                      style: AppStyle.black16medium.copyWith(
                        color: themeProvider.appTheme == ThemeMode.light ? AppColors.black : AppColors.white,
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, LoginScreen.routeName);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.login,
                      style: AppStyle.primary14bold.copyWith(
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColorLight,
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
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
