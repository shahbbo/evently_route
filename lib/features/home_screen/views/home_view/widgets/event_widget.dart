import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/features/create_event_screen/data/event_model.dart';
import 'package:event_planning_app/features/event_details_screen/presentation/pages/event_details.dart';
import 'package:event_planning_app/features/home_screen/views/home_view/provider/home_provider.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/recources/app_colors.dart';
import '../../../../../core/recources/app_styles.dart';
import '../../../../fire_base/firebase_func.dart';

class EventWidget extends StatefulWidget {

  final EventModel eventModel;

  const EventWidget({super.key,required this.eventModel});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}
class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    bool isFav = widget.eventModel.isFavorite!;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetails.routeName, arguments: widget.eventModel);
      },
      child: Container(
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.all(5),
        height: height * .25,
        width: width,
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(widget.eventModel.image ?? ''), fit: BoxFit.fill),
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
                    widget.eventModel.date?.substring(0,2) ?? '',
                    textAlign: TextAlign.center,
                    style: AppStyle.primary20bold,
                  ),
                  Text(
                    widget.eventModel.date?.substring(2,5) ?? '',
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
                    widget.eventModel.title ?? '',
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
                        print("Is fav: $isFav");
                        print("Event model: ${widget.eventModel.toJson()}");
                        isFav = !isFav;
                        print("Is fav after: $isFav");
                        widget.eventModel.isFavorite = isFav;
                        print("Event model after: ${widget.eventModel.toJson()}");
                        homeProvider.updateEvent(
                            id: widget.eventModel.id ?? '',
                            updatedData: {
                              'isFavorite': isFav,
                            });
                        homeProvider.editEvent(
                          id: widget.eventModel.id ?? '',
                          isFavorite: isFav,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
