import 'package:event_planning_app/features/home_screen/views/home_view/home_view.dart';
import 'package:event_planning_app/features/home_screen/views/like_view/like_view.dart';
import 'package:event_planning_app/features/home_screen/views/map_view/map_view.dart';
import 'package:event_planning_app/features/home_screen/views/profile_view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/recources/app_colors.dart';
import '../../core/recources/assets_manager.dart';
import '../create_event_screen/presentation/pages/create_event.dart';



class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> viewsList = [ HomeView(),  MapView(),  LikeView(),  ProfileView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false, //يثبت الفلوتنج بوتون دلوقتي
      extendBodyBehindAppBar: true,
      body: viewsList[selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
          onPressed: (){
            Navigator.pushNamed(context, CreateEvent.routeName);
          },
        child: Icon(Icons.add,color: AppColors.white,size: 40,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        color: Colors.transparent,
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: AppColors.transparent,
          ),
          child: BottomAppBar(
            color: Theme.of(context).primaryColor,
            notchMargin: 0,
            padding: EdgeInsets.zero,
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: BottomNavigationBar(
              type:BottomNavigationBarType.fixed ,
              unselectedItemColor: AppColors.white,
              selectedItemColor: AppColors.white,
              landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                currentIndex: selectedIndex,
                onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
                  },
                items: [
                  bottomNavBarItem(
                      index: 0,
                      iconName: AssetsManager.iconHomeSvg,
                      selectedIconName: AssetsManager.iconHome1Svg,
                      label: AppLocalizations.of(context)!.homeTab),
                  bottomNavBarItem(
                      index: 1,
                      iconName: AssetsManager.iconMapSvg,
                      selectedIconName: AssetsManager.iconMap1Svg,
                      label: AppLocalizations.of(context)!.mapTab),
                  bottomNavBarItem(
                      index: 2,
                      iconName: AssetsManager.iconLikeSvg,
                      selectedIconName: AssetsManager.iconLike1Svg,
                      label: AppLocalizations.of(context)!.likeTab),
                  bottomNavBarItem(
                      index: 3,
                      iconName: AssetsManager.iconProfileSvg,
                      selectedIconName: AssetsManager.iconProfile1Svg,
                      label: AppLocalizations.of(context)!.profileTab),
                ]),
          ),
        ),
      ),

    );
  }
  BottomNavigationBarItem bottomNavBarItem(
      {required int index,
      required String iconName,
      required String selectedIconName,
      required String label}) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(selectedIndex == index ? selectedIconName : iconName),
        label: label);
  }
}
