import 'package:event_planning_app/core/network/local/cache_helper.dart';
import 'package:event_planning_app/core/recources/app_styles.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/recources/app_colors.dart';
import '../../../../core/recources/assets_manager.dart';
import '../../../auth/presentation/pages/create_account.dart';

class OnBoarding2 extends StatefulWidget {
  const OnBoarding2({super.key});

  static const routeName = '/onBoarding2';

  @override
  State<OnBoarding2> createState() => _OnBoarding2State();
}

class _OnBoarding2State extends State<OnBoarding2> {

  int currentIndex = 0;
  // PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      AssetsManager.onBording2,
      AssetsManager.onBording3,
      AssetsManager.onBording4,
    ];
    List<String> imagesDark = [
      AssetsManager.onBording2Dark,
      AssetsManager.onBording3Dark,
      AssetsManager.onBording4Dark,
    ];
    List<String> titles = [
      AppLocalizations.of(context)!.onBT2,
      AppLocalizations.of(context)!.onBT3,
      AppLocalizations.of(context)!.onBT4,
    ];
    List<String> subtitles = [
      AppLocalizations.of(context)!.onBST2,
      AppLocalizations.of(context)!.onBST3,
      AppLocalizations.of(context)!.onBST4,
    ];
    double height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: height * .03,
            ),
            SvgPicture.asset(AssetsManager.eventlyLogo,),
            SizedBox(
              height: height * .02,
            ),
            SizedBox(
              height: height * .4,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                // controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                    // pageController.jumpToPage(index);
                  });
                },
                children: List.generate(3, (index) {
                  return SvgPicture.asset(
                    themeProvider.appTheme == ThemeMode.light ? images[index] : imagesDark[index],
                  );
                }),
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Text(
              titles[currentIndex],
              style: AppStyle.primary20bold,
            ),
            SizedBox(
              height: height * .02,
            ),
            Text(
              subtitles[currentIndex],
              style: AppStyle.black16medium.copyWith(
                color: themeProvider.appTheme == ThemeMode.light ? Colors.black : Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height * .03,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blue, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                      onPressed: (){
                        currentIndex == 0
                            ? Navigator.of(context).pop()
                            : setState(() {
                              currentIndex--;
                        });
                        // pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                      icon: Icon(Icons.arrow_back, color: AppColors.blue, size: 30,)),
                ),
                Spacer(),
                SizedBox(
                  // width: 100,
                  height: height * .01,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          height: height * .01,
                          width: currentIndex == index ? 20 : 10,
                          decoration: BoxDecoration(
                            color: currentIndex == index ? AppColors.blue : AppColors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                  ),
                ),
                Spacer(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blue, width: 2),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: IconButton(
                      onPressed: (){
                        if(currentIndex == 2) {
                          print(currentIndex);
                          CacheHelper.saveData(key: 'OnBoarding', value: true);
                          Navigator.pushNamed(context, CreateAccount.routeName);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        }else{
                          setState(() {
                              currentIndex++;
                        });
                        }
                        // pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                      },
                      icon: Icon(Icons.arrow_forward, color: AppColors.blue, size: 30,)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
