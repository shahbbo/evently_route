import 'package:event_planning_app/features/auth/presentation/provider/auth_provider/auth_provider.dart';
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
import 'create_account.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool obscureText = true;

GlobalKey<FormState> formKey = GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  hintText: AppLocalizations.of(context)!.email,
                  prefixIcon: Icon(Icons.email,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.email_required;
                    }
                  },
                ),
                SizedBox(
                  height: height * .01,
                ),
                CustomTextFormField(
                  controller: passwordController,
                  borderColor: AppColors.gray,
                  hintText: AppLocalizations.of(context)!.password,
                  prefixIcon: Icon(Icons.lock,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  ),
                  obscureText: obscureText,
                  suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: obscureText ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.gray : AppColors.white,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return AppLocalizations.of(context)!.password_required;
                    }
                  },
                ),
                SizedBox(
                  height: height * .015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, ForgetPassword.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forget_password,
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
                  height: height * .02,
                ),
                CustomButton(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      authProvider.signIn(emailController.text, passwordController.text).then((value) {
                        if(value != null){
                          Navigator.pushNamed(context, HomeScreen.routeName , arguments: value);
                        }
                      });
                    }
                  },
                  buttonColor: AppColors.primaryColorLight,
                  buttonName: AppLocalizations.of(context)!.login,
                  textColor: AppColors.white,
                  borderColor: AppColors.primaryColorLight,
                ),
                SizedBox(
                  height: height * .02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(AppLocalizations.of(context)!.have_not_account,
                        style: AppStyle.black16medium.copyWith(
                        color: themeProvider.appTheme == ThemeMode.light ? AppColors.black : AppColors.white,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, CreateAccount.routeName);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create_account,
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
                  height: height * .02,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryColorLight,
                        thickness: 1,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text( AppLocalizations.of(context)!.or,style: AppStyle.primary14medium,),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.primaryColorLight,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .02,
                ),
                CustomButton(
                  onTap: (){},
                  textColor: AppColors.primaryColorLight,
                  buttonColor: Theme.of(context).primaryColorLight,
                  buttonName: AppLocalizations.of(context)!.loginWithGoogle,
                  borderColor: AppColors.primaryColorLight,
                  icon: AssetsManager.googleIcon,
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
