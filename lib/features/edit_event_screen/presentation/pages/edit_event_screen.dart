import 'package:cherry_toast/cherry_toast.dart';
import 'package:event_planning_app/features/home_screen/views/home_view/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/recources/app_colors.dart';
import '../../../../core/recources/app_styles.dart';
import '../../../../core/recources/assets_manager.dart';
import '../../../../core/reuseable_widgets/custom_button.dart';
import '../../../../core/reuseable_widgets/custom_text_form_feild.dart';
import '../../../../core/reuseable_widgets/tab_event_widget.dart';
import '../../../create_event_screen/data/event_model.dart';
import '../../../provider/theme_provider.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  static const String routeName = 'editEvent';

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  List<String> eventList = [];
  int selectedTab = 0;
  String category = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String date = '';
  String time = '';
  String location = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? eventImage;
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

  void getEventNameList(BuildContext context) {
    eventList = [
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
  }

  List<String> arEventList = [
    'الرياضة',
    'عيد ميلاد',
    'اجتماع',
    'العاب',
    'الطعام',
    'اجازة',
    'هوايات'
        'نادى القراءة',
    'ورشة عمل',
  ];
  List<String> enEventList = [
    'Sport',
    'Birthday',
    'Meeting',
    'Gaming',
    'Eating',
    'Holiday',
    'Exhibition',
    'Book Club',
    'Work Shop',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final EventModel eventModel =
          ModalRoute.of(context)!.settings.arguments as EventModel;
      getEventNameList(context);
      setState(() {
        category = eventModel.category ?? '';
        if (category.isNotEmpty && arEventList.contains(category)) {
          selectedTab = arEventList.indexOf(category);
          eventImage = eventImageList[selectedTab];
        } else if (category.isNotEmpty && enEventList.contains(category)) {
          selectedTab = enEventList.indexOf(category);
          eventImage = eventImageList[selectedTab];
        }
        titleController.text = eventModel.title ?? '';
        descriptionController.text = eventModel.description ?? '';
        date = eventModel.date ?? '';
        time = eventModel.time ?? '';
      });
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        forceMaterialTransparency: true,
        title: Text(
          AppLocalizations.of(context)!.editEvent,
          style: AppStyle.primary20bold.copyWith(color: AppColors.blue),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.blue),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          return Form(
            key: formKey,
            child: Padding(
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
                          image: AssetImage(eventImage ?? ''),
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
                                category = selectedTab == 0
                                    ? eventList[0]
                                    : eventList[selectedTab];
                                eventImage = eventImageList[selectedTab];
                              });
                            },
                            dividerColor: Colors.transparent,
                            isScrollable: true,
                            indicatorColor: Colors.transparent,
                            labelPadding: EdgeInsets.all(5),
                            tabs: eventList
                                .map((eventName) => TabEventWidget(
                                      tabName: eventName,
                                      isCreateEvent: true,
                                      selectedTab: selectedTab ==
                                          eventList.indexOf(eventName),
                                    ))
                                .toList())),
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: AppStyle.black16medium.copyWith(
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    CustomTextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!.pleaseEnterTitle;
                        }
                        return null;
                      },
                      borderColor: themeProvider.appTheme == ThemeMode.light
                          ? AppColors.gray
                          : AppColors.blue,
                      prefixIcon: Icon(
                        Icons.edit_note_outlined,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.gray
                            : AppColors.white,
                      ),
                      hintText: AppLocalizations.of(context)!.title,
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: AppStyle.black16medium.copyWith(
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * .015,
                    ),
                    CustomTextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseEnterDescription;
                        }
                        return null;
                      },
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
                        Icon(
                          Icons.date_range_outlined,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.black
                              : AppColors.white,
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
                            onPressed: () => onDatePicked(),
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
                        Icon(
                          Icons.access_time,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.black
                              : AppColors.white,
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
                            onPressed: () => onTimePicked(),
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
                        color: themeProvider.appTheme == ThemeMode.light
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                    SizedBox(
                      height: height * .01,
                    ),
                    InkWell(
                      onTap: () {},
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
                              child: Icon(
                                Icons.location_searching,
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
                            Icon(
                              Icons.arrow_forward_ios,
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
                      onTap: () {
                        updateEvent();
                      },
                      buttonColor: AppColors.blue,
                      buttonName: AppLocalizations.of(context)!.editEvent,
                      textColor: AppColors.white,
                      borderColor: AppColors.blue,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  void onDatePicked() async {
    AppThemeProvider themeProvider =
        Provider.of<AppThemeProvider>(context, listen: false);
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
        date = DateFormat('d MMMM yyyy').format(selectedDate);
      });
    }
  }
  void onTimePicked() async {
    AppThemeProvider themeProvider =
        Provider.of<AppThemeProvider>(context, listen: false);
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
  Future<void> updateEvent() async {
    HomeProvider homeProvider =
        Provider.of<HomeProvider>(context, listen: false);
    EventModel model = ModalRoute.of(context)!.settings.arguments as EventModel;
    if (formKey.currentState!.validate()) {
      Map<String, dynamic> updatedData = {};
      if (category != model.category && category.isNotEmpty) updatedData['category'] = category;
      if (titleController.text != model.title && titleController.text.isNotEmpty) updatedData['title'] = titleController.text;
      if (descriptionController.text != model.description && descriptionController.text.isNotEmpty) updatedData['description'] = descriptionController.text;
      if (date != model.date && date.isNotEmpty) updatedData['date'] = date;
      if (time != model.time && time.isNotEmpty) updatedData['time'] = time;
      if (eventImage != model.image && eventImage != null) updatedData['image'] = eventImage;
      print("Updated data: $updatedData");
      await homeProvider.updateEvent(id: model.id ?? '', updatedData: updatedData)
          .then((value) async {
            Navigator.pop(context , homeProvider.getEventById(model.id ?? ''));
            print("Event updated : ${homeProvider.getEventById(model.id ?? '').toString()}");
        CherryToast.success(
          title: Text(AppLocalizations.of(context)!.eventUpdated),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
        ).show(context);
      });
    }
  }
}
