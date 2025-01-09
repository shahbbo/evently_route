import 'package:event_planning_app/features/create_event_screen/data/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../fire_base/firebase_func.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<String> eventList = [] ;
  void getEventNameList(BuildContext context) {
    eventList = [
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
  }
  List<EventModel> events = [];
  Future<void> getAllEvents() async {
    FireBaseFunctions.getEventsCollection().get().then((value) {
      events = value.docs.map((doc) => doc.data()).toList();
      if (currentIndex == 0) {
        filteredEvents = events;
      }
      notifyListeners();
    }).catchError((e) {
      print("Error: $e");
    });
  }
  List<EventModel> filteredEvents = [];
  void filterEvents(BuildContext context) {
    if (eventList.isEmpty) {
      getEventNameList(context);
    }
    if (currentIndex == 0) {
      filteredEvents = events;
    } else {
      filteredEvents = events.where((element) => element.category == eventList[currentIndex]).toList();
    }
    notifyListeners();
  }
/*  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 0) {
      getAllEvents();
    } else {
      getFilteredEvents();
    }
    notifyListeners();
  }
  void getFilteredEvents() async {
    getEventNameList;
    FireBaseFunctions.getEventsCollection().get().then((value) {
      events = value.docs.map((doc) => doc.data()).toList();
      filteredEvents = events.where((element) => element.category == eventList[currentIndex]).toList();
      notifyListeners();
    }).catchError((e) {
      print("Error: $e");
    });
  }*/
}