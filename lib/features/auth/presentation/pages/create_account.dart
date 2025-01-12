import 'package:cherry_toast/cherry_toast.dart';
import 'package:event_planning_app/features/auth/presentation/provider/auth_provider/auth_provider.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/local/cache_helper.dart';
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

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
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
        child: Form(
          key: formKey,
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
                  controller: nameController,
                  prefixIcon: Icon(Icons.person,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.name_required;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .01,
                ),
                CustomTextFormField(
                  borderColor: AppColors.gray,
                  hintText: AppLocalizations.of(context)!.email,
                  controller: emailController,
                  prefixIcon: Icon(Icons.email,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.email_required;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                CustomTextFormField(
                  controller: passwordController,
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
                  validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.password_required;
                    }else if(value.length < 6){
                      return AppLocalizations.of(context)!.password_length;
                    }else if (rePasswordController.text != passwordController.text){
                      return AppLocalizations.of(context)!.password_not_match;
                    }
                    return null;
                    },
                ),
                SizedBox(
                  height: height * .015,
                ),
                CustomTextFormField(
                  controller: rePasswordController,
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
                  validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.password_required;
                    }else if(value.length < 6){
                      return AppLocalizations.of(context)!.password_length;
                    }else if (rePasswordController.text != passwordController.text){
                      return AppLocalizations.of(context)!.password_not_match;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                CustomButton(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      authProvider.signUp1(emailController.text, passwordController.text, nameController.text).then((value) async {
                        if(value != null){
                          await authProvider.getUserInfo();
                          CacheHelper.saveData(key: 'uid', value: authProvider.uid);
                          CacheHelper.saveData(key: 'email', value: authProvider.email);
                          CacheHelper.saveData(key: 'name', value: authProvider.name);
                          Navigator.pushNamed(context, HomeScreen.routeName).then((value) {
                            emailController.clear();
                            passwordController.clear();
                            rePasswordController.clear();
                            nameController.clear();
                            CherryToast.success(
                              title: Text(AppLocalizations.of(context)!.register_success),
                            ).show(context);
                          });
                        }
                      });
                    }
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
      ),

    );
  }
}
