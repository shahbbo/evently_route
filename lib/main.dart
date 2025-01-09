import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/features/edit_event_screen/presentation/pages/edit_event_screen.dart';
import 'package:event_planning_app/features/event_details_screen/presentation/pages/event_details.dart';
import 'package:event_planning_app/features/on_boarding/presentation/pages/on_boarding1.dart';
import 'package:event_planning_app/features/on_boarding/presentation/pages/on_boarding2.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/network/local/cache_helper.dart';
import 'core/recources/app_theme.dart';
import 'features/auth/presentation/pages/create_account.dart';
import 'features/auth/presentation/pages/forget_password.dart';
import 'features/auth/presentation/pages/login_screen.dart';
import 'features/create_event_screen/presentation/pages/create_event.dart';
import 'features/home_screen/home_screen.dart';
import 'features/home_screen/views/home_view/provider/home_provider.dart';
import 'features/provider/language_provider.dart';
import 'features/provider/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'features/fire_base/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  String? initialRoute;
  if (CacheHelper.getData(key: 'OnBoarding') == null) {
    initialRoute = OnBoarding1.routeName;
  } else {
    initialRoute = LoginScreen.routeName;
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseFirestore.instance.disableNetwork();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AppLanguageProvider()..loadLanguageFromCache()),
    ChangeNotifierProvider(create: (context) => AppThemeProvider()..loadThemeFromCache()),
    ChangeNotifierProvider(create: (context) => HomeProvider()..getAllEvents()),
  ], child: MyApp(initialRoute: initialRoute)));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

 final String initialRoute;

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        OnBoarding1.routeName: (context) => OnBoarding1(),
        OnBoarding2.routeName: (context) => OnBoarding2(),
        LoginScreen.routeName: (context) => LoginScreen(),
        CreateAccount.routeName: (context) => CreateAccount(),
        ForgetPassword.routeName: (context) => ForgetPassword(),
        HomeScreen.routeName: (context) => HomeScreen(),
        EventDetails.routeName: (context) => EventDetails(),
        EditEventScreen.routeName: (context) => EditEventScreen(),
        CreateEvent.routeName: (context) => CreateEvent(),
      },
      localeResolutionCallback: (deviceLocal, supportedLocales) {
        for (var locale in supportedLocales) {
          if (deviceLocal != null &&
              deviceLocal.languageCode == locale.languageCode) {
            return deviceLocal;
          }
        }
        return supportedLocales.first;
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(languageProvider.appLanguage),
    );
  }
}
