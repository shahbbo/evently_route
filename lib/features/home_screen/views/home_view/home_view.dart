import 'package:event_planning_app/core/network/local/cache_helper.dart';
import 'package:event_planning_app/core/reuseable_widgets/tab_event_widget.dart';
import 'package:event_planning_app/features/home_screen/views/home_view/provider/home_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../../core/recources/app_colors.dart';
import '../../../../core/recources/app_styles.dart';
import '../../../provider/language_provider.dart';
import '../../../provider/theme_provider.dart';
import 'widgets/event_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key , this.userData});

  final User? userData;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppLanguageProvider languageProvider = Provider.of<AppLanguageProvider>(context);
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    List<String> eventList = [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.eating,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.book_club,
      AppLocalizations.of(context)!.work_shop,
    ];
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: height * 0.018),
            height: height * 0.25,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome_back,
                            style: AppStyle.white14regular,
                          ),
                          Text(
                            'Mahmoud Shahbo',
                            style: AppStyle.white24bold,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.white,
                              ),
                              Text(
                                AppLocalizations.of(context)!.cairo,
                                style: AppStyle.white14medium,
                              ),
                              Text(
                                ' , ',
                                style: AppStyle.white14medium,
                              ),
                              Text(
                                AppLocalizations.of(context)!.egypt,
                                style: AppStyle.white14medium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          themeProvider.changeAppTheme(
                              themeProvider.isDarkTheme == false
                                  ? true
                                  : false);
                          CacheHelper.saveData(key: 'appTheme', value: themeProvider.appTheme == ThemeMode.light ? true : false);
                        },
                        child: Icon(
                          Icons.wb_sunny_outlined,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          languageProvider.changeAppLanguage(
                              languageProvider.appLanguage == 'en' ? 'ar' : 'en');
                          CacheHelper.saveData(key: 'appLanguage', value: languageProvider.appLanguage == 'en' ? true : false);
                          Provider.of<HomeProvider>(context,listen: false).getAllEvents();
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 3),
                          height: height * 0.04,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            languageProvider.appLanguage == 'en'
                                ? 'EN'
                                : 'AR',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
                  child: DefaultTabController(
                      length: eventList.length,
                      initialIndex: 0,
                      child: TabBar(
                          onTap: (index){
                         setState(() {
                           homeProvider.currentIndex = index;
                           homeProvider.filterEvents(context);
                         });
                       },
                          tabAlignment: TabAlignment.start,
                          labelColor: Colors.red,
                          dividerColor: Colors.transparent,
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          labelPadding: EdgeInsets.all(5),
                          tabs: eventList.map((eventName) => TabEventWidget(
                                    selectedTab : homeProvider.currentIndex == eventList.indexOf(eventName)
                                        ? true
                                        : false,
                                    isCreateEvent: false,
                                    tabName: eventName,
                                  ))
                              .toList()
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8,),
            child: SizedBox(
              height: height * 0.73,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                return EventWidget(
                  eventModel: homeProvider.filteredEvents[index],
                );
              },
                itemCount: homeProvider.filteredEvents.length,
                separatorBuilder: (context, index) => SizedBox(height: height*0.005,),
              ),
            ),
          )
        ],
      ),
    );
  }
}
