import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/recources/app_colors.dart';
import '../../../../../core/recources/app_styles.dart';

class EventWidget extends StatefulWidget {
  final String image;
  final String eventName;

  const EventWidget({super.key, required this.image, required this.eventName});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

bool isFav = false;

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(5),
      height: height * .25,
      width: width,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: AssetImage(widget.image), fit: BoxFit.fill),
        border: Border.all(width: 2, color: AppColors.primaryColorLight),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8 , top: 3 , bottom: 3),
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light
                  ? AppColors.bglight.withOpacity(0.9)
                  : AppColors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text(
                  '21',
                  textAlign: TextAlign.center,
                  style: AppStyle.primary20bold,
                ),
                Text(
                  'NOV',
                  textAlign: TextAlign.center,
                  style: AppStyle.primary14bold,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light
                  ? AppColors.bglight.withOpacity(0.9)
                  : AppColors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.eventName,
                  textAlign: TextAlign.center,
                  style: AppStyle.primary20bold.copyWith(
                    color: themeProvider.appTheme == ThemeMode.light
                        ? AppColors.black
                        : AppColors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: AppColors.primaryColorLight,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      isFav = !isFav;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
