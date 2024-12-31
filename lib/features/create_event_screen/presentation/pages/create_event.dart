import 'package:event_planning_app/core/reuseable_widgets/custom_button.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/recources/app_colors.dart';
import '../../../../core/recources/app_styles.dart';
import '../../../../core/recources/assets_manager.dart';
import '../../../../core/reuseable_widgets/custom_text_form_feild.dart';
import '../../../../core/reuseable_widgets/tab_event_widget.dart';

class CreateEvent extends StatefulWidget {
  static const String routeName = 'createEvent';

  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  int selectedTab = 0;

  String time = '';
  String date = '';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    List<String> eventList = [
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
    List<String> eventImageList = [
      AssetsManager.sportBg,
      AssetsManager.birthdayBg,
      AssetsManager.meetingBg,
      AssetsManager.gamingBg,
      AssetsManager.eatingBg,
      AssetsManager.holidayBg,
      AssetsManager.exhibitionBg,
      AssetsManager.bookclubBg,
      AssetsManager.workshopBg,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        forceMaterialTransparency: true,
        title: Text(
          AppLocalizations.of(context)!.create_event,
          style: AppStyle.primary14bold.copyWith(
              color: AppColors.blue
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.blue),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: height * .02,
              ),
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(eventImageList[selectedTab]),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              DefaultTabController(
                  length: eventList.length,
                  child: TabBar(
                      tabAlignment: TabAlignment.start,
                      onTap: (index) {
                        setState(() {
                          selectedTab = index;
                        });
                      },
                      dividerColor: Colors.transparent,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelPadding: EdgeInsets.all(5),
                      tabs: eventList
                          .map((eventName) =>
                          TabEventWidget(
                            tabName: eventName,
                            isCreateEvent: true,
                            selectedTab:
                            selectedTab == eventList.indexOf(eventName),
                          ))
                          .toList())),
              Text(
                AppLocalizations.of(context)!.title,
                style: AppStyle.black16medium.copyWith(
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors
                      .black : AppColors.white,
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              CustomTextFormField(
                borderColor: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.gray
                    : AppColors.blue,
                prefixIcon: Icon(Icons.edit_note_outlined,
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors
                      .gray : AppColors.white,
                ),
                hintText: AppLocalizations.of(context)!.title,
              ),
              SizedBox(
                height: height * .01,
              ),
              Text(
                AppLocalizations.of(context)!.description,
                style: AppStyle.black16medium.copyWith(
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors
                      .black : AppColors.white,
                ),
              ),
              SizedBox(
                height: height * .015,
              ),
              CustomTextFormField(
                borderColor: themeProvider.appTheme == ThemeMode.light
                    ? AppColors.gray
                    : AppColors.blue,
                hintText: AppLocalizations.of(context)!.description,
                numLines: 5,
              ),
              SizedBox(
                height: height * .015,
              ),
              Row(
                children: [
                  Icon(Icons.date_range_outlined,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors
                        .black : AppColors.white,
                  ),
                  SizedBox(
                    width: width * .015,
                  ),
                  Text(
                    AppLocalizations.of(context)!.eventDate,
                    style: AppStyle.black16medium.copyWith(
                      color: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () => onDatePicked(context),
                      child: Text(
                        date == ''
                            ? AppLocalizations.of(context)!.chooseDate
                            : date,
                        style: AppStyle.primary14bold.copyWith(
                          color: AppColors.blue,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height * .015,
              ),
              Row(
                children: [
                  Icon(Icons.access_time,
                    color: themeProvider.appTheme == ThemeMode.light ? AppColors
                        .black : AppColors.white,
                  ),
                  SizedBox(
                    width: width * .015,
                  ),
                  Text(
                    AppLocalizations.of(context)!.eventTime,
                    style: AppStyle.black16medium.copyWith(
                      color: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.black
                          : AppColors.white,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () => onTimePicked(context),
                      child: Text(
                        time == ''
                            ? AppLocalizations.of(context)!.chooseTime
                            : time,
                        style: AppStyle.primary14bold.copyWith(
                          color: AppColors.blue,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: height * .015,
              ),
              Text(
                AppLocalizations.of(context)!.location,
                style: AppStyle.black16medium.copyWith(
                  color: themeProvider.appTheme == ThemeMode.light ? AppColors.black : AppColors.white,
                ),
              ),
              SizedBox(
                height: height * .01,
              ),
              InkWell(
                onTap: (){},
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.blue,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.location_searching,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(
                        width: width * .02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.chooseLocation,
                        style: AppStyle.primary14bold.copyWith(
                          color: AppColors.blue,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios,
                        color: AppColors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomButton(
                  onTap: (){},
                  buttonColor: AppColors.blue,
                  buttonName: AppLocalizations.of(context)!.addEvent,
                  textColor: AppColors.white,
                  borderColor: AppColors.blue,)
            ],
          ),
        ),
      ),
    );
  }

  void onDatePicked(BuildContext context) async {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context, listen: false);
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: themeProvider.appTheme == ThemeMode.light
              ? ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: AppColors.black,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: AppColors.white,
          )
              : ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.blue,
              onPrimary: AppColors.black,
              surface: AppColors.primaryColorDark,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.white,
          ),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      setState(() {
        date = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }
  void onTimePicked(BuildContext context) async {
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(
        context, listen: false);
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: themeProvider.appTheme == ThemeMode.light
              ? ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.blue,
              onPrimary: AppColors.black,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: AppColors.white,
          )
              : ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppColors.blue,
              onPrimary: AppColors.black,
              surface: AppColors.primaryColorDark,
              onSurface: AppColors.white,
            ),
            dialogBackgroundColor: AppColors.white,
          ),
          child: child!,
        );
      },
    );
    if (selectedTime != null) {
      setState(() {
        time = DateFormat.jm().format(
          DateTime(2021, 1, 1, selectedTime.hour, selectedTime.minute),
        );
      });
    }
  }
}

