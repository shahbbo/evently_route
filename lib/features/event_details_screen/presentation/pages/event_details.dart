import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:event_planning_app/core/recources/app_colors.dart';
import 'package:event_planning_app/features/edit_event_screen/presentation/pages/edit_event_screen.dart';
import 'package:event_planning_app/features/home_screen/views/home_view/provider/home_provider.dart';
import 'package:event_planning_app/features/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/recources/app_styles.dart';
import '../../../create_event_screen/data/event_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key,});
  static const String routeName = 'eventDetails';

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {

/*  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    eventModel = ModalRoute.of(context)!.settings.arguments as EventModel;
  }
  @override
  void didUpdateWidget(covariant EventDetails oldWidget) {
    super.didUpdateWidget(oldWidget);
    final updatedEvent = ModalRoute.of(context)!.settings.arguments as EventModel;
    if (updatedEvent != eventModel) {
      setState(() {
        eventModel = updatedEvent;
      });
    }
  }*/
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    AppThemeProvider themeProvider = Provider.of<AppThemeProvider>(context);
    bool isLight = themeProvider.appTheme == ThemeMode.light;
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeProvider.getFavoriteEvents();
      homeProvider.getAllEvents();
    });
    EventModel eventModel = ModalRoute.of(context)!.settings.arguments as EventModel;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.eventDetails,
          style: AppStyle.primary20bold.copyWith(color: AppColors.blue),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        forceMaterialTransparency: true,
        iconTheme: IconThemeData(color: AppColors.blue),
        actions: [
          IconButton(
            onPressed: () async {
              // Navigator.pushNamed(context, EditEventScreen.routeName, arguments: eventModel).then((value) async {
              //   await homeProvider.getAllEvents();
              //   setState(() {
              //     print('eventModel: $eventModel');
              //     eventModel = homeProvider.getEventById(eventModel.id!) as EventModel;
              //     print('updatedEventModel: $eventModel');
              //   });
              // });
              final updatedEventModel = await Navigator.pushNamed(
                context,
                EditEventScreen.routeName,
                arguments: eventModel,
              ) as EventModel?;
              if (updatedEventModel != null) {
                setState(() {
                  eventModel = updatedEventModel;
                  print('updatedEventModel: $updatedEventModel');
                });
              }
            },
            icon: Icon(
              Icons.edit_note_outlined,
              color: AppColors.blue,
              size: 30,
            ),
          ),
          IconButton(
              onPressed: () {
                homeProvider.deleteEvent(eventModel.id!).then((onValue) {
                  homeProvider.getAllEvents();
                  CherryToast.success(
                    title: Text('Event Deleted Successfully'),
                    animationCurve: Curves.easeIn,
                    animationDuration: Duration(milliseconds: 500),
                    autoDismiss: true,
                    animationType: AnimationType.fromTop,
                  );
                  Navigator.pop(context);
                });
              },
              icon: Icon(
                Icons.delete_outlined,
                color: AppColors.red,
              )),
        ],
      ),
      body: Consumer<HomeProvider>(
  builder: (context, provider, child) {
  return Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(eventModel.image ?? ''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Text(
              eventModel.title ?? '',
              style: AppStyle.primary20bold.copyWith(color: AppColors.blue),
            ),
            SizedBox(
              height: height * .01,
            ),
            Container(
              height: height * .08,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(5),
                        child: Icon(
                          Icons.calendar_month,
                          color: isLight ? AppColors.white : AppColors.black,
                          size: 35,
                        )),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventModel.date ?? '',
                        style: AppStyle.primary14bold
                            .copyWith(color: AppColors.blue),
                      ),
                      Text(
                        eventModel.time ?? '',
                        style: AppStyle.primary14bold
                            .copyWith(color: AppColors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Container(
              height: height * .08,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.blue),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.gps_fixed_outlined,
                          color: isLight ? AppColors.white : AppColors.black,
                          size: 35,
                        )),
                  ),
                  Text(
                    'Cairo, Egypt',
                    style:
                        AppStyle.primary14bold.copyWith(color: AppColors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * .01,
            ),
            Text(
              'Description',
              style: AppStyle.primary20bold
                  .copyWith(color: isLight ? AppColors.black : AppColors.white),
            ),
            SizedBox(
              height: height * .005,
            ),
            Text(
              eventModel.description ?? '',
              style: AppStyle.primary14bold
                  .copyWith(color: isLight ? AppColors.black : AppColors.white),
            ),
          ],
        ),
      );
  },
),
    );
  }
}
