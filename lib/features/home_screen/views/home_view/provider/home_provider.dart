import 'package:event_planning_app/features/create_event_screen/data/event_model.dart';
import 'package:flutter/material.dart';

import '../../../../fire_base/firebase_func.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;


  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  EventModel? eventModel;

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
  void filterEvents(String filter) {
    if (currentIndex == 0) {
      filteredEvents = events;
    }
    filteredEvents = events.where((element) => element.category == filter).toList();
    notifyListeners();
  }
}