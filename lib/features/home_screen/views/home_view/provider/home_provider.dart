import 'package:event_planning_app/features/create_event_screen/data/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../core/fire_base/firebase_func.dart';

class HomeProvider extends ChangeNotifier {
  int currentIndex = 0;
  List<String> eventList = [];

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
  Future<void> filterEvents(BuildContext context) async {
    if (eventList.isEmpty) getEventNameList(context);
    if (currentIndex == 0) {
      filteredEvents = events;
    } else {
      filteredEvents = events
          .where((element) => element.category == enEventList[currentIndex])
          .toList();
    }
    notifyListeners();
  }

  EventModel filteredEventById(String id) {
    return events.firstWhere((element) => element.id == id);
  }

  EventModel? eventModel;
  Future<EventModel?> getEventById(String id) async {
    try {
      var doc = await FireBaseFunctions.getEventsCollection().doc(id).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          eventModel = EventModel.fromJson(data);
          notifyListeners();
          return eventModel;
        } else {
          print("Document data is null or not a Map");
          return null;
        }
      } else {
        print("Document does not exist");
        return null;
      }
    } catch (e) {
      print("Error fetching document: $e");
      return null;
    }
  }

  // fav section
  List<EventModel> favoriteEvents = [];
  Future <void> getFavoriteEvents() async {
    await FireBaseFunctions.getEventsCollection()
        .where('isFavorite', isEqualTo: true)
        .get()
        .then((onValue) {
      favoriteEvents = onValue.docs.map((doc) => doc.data()).toList();
    }).catchError((e) {
    });
    notifyListeners();
  }

  /*
  // edit section
  */
  Future<void> updateEvent(
      {required String id, required Map<String, dynamic> updatedData}) async {
    FireBaseFunctions.getEventsCollection().doc(id).get().then((doc) {
      if (doc.exists) {
        doc.reference.update(updatedData).then((value) async {
          print("Document updated successfully");
          await getAllEvents();
          await getFavoriteEvents();
          await getEventById(id);
          notifyListeners();
        }).catchError((e) {
          print("Error updating document: $e");
        });
      } else {
        print("Document does not exist");
      }
    }).catchError((e) {
      print("Error fetching document: $e");
    });
    notifyListeners();
  }
  /* Future<void> editEvent({
    required String id,
    String? title,
    String? description,
    String? date,
    String? time,
    String? image,
    String? category,
    bool? isFavorite,
  }) async {
    Map<String, dynamic> updatedData = {};
    if (title != null) updatedData['title'] = title;
    if (date != null) updatedData['date'] = date;
    if (time != null) updatedData['time'] = time;
    if (image != null) updatedData['image'] = image;
    if (category != null) updatedData['category'] = category;
    if (isFavorite != null) updatedData['isFavorite'] = isFavorite;
    if (description != null) updatedData['description'] = description;
    print("Updated data: $updatedData");
    FireBaseFunctions.getEventsCollection()
        .doc(id)
        .update(
          updatedData,
        )
        .then((value) async {
      print("Event updated");
      await getAllEvents();
      await getFavoriteEvents();
      notifyListeners();
    }).catchError((e) {
      print("Error: $e");
    });
    notifyListeners();
  }*/


  // delete section
  Future<void> deleteEvent(String id) async {
    print("Event id: $id");
    FireBaseFunctions.getEventsCollection()
        .doc(id)
        .delete()
        .then((value) async {
      print("Event deleted");
      await getAllEvents();
    }).catchError((e) {
      print("Error: $e");
    });
    notifyListeners();
  }
}
