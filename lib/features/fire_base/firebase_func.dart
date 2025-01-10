import 'package:cloud_firestore/cloud_firestore.dart';
import '../create_event_screen/data/event_model.dart';
class FireBaseFunctions {
  static CollectionReference<EventModel> getEventsCollection() {
    return FirebaseFirestore.instance.collection(EventModel.collectionName)
        .withConverter<EventModel>(
      fromFirestore: (snapshots, _) => EventModel.fromJson(snapshots.data()!),
      toFirestore: (eventModel, _) => eventModel.toJson(),
    );
  }
  static Future<void> addEvent(EventModel event) {
    CollectionReference collection = getEventsCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
  static void addEventObject(){
    FirebaseFirestore.instance.collection(EventModel.collectionName)
        .withConverter(
        fromFirestore: (snapshots, _) => EventModel.fromJson(snapshots.data()!),
        toFirestore: (eventModel, _) => eventModel.toJson());
  }
  static Future<void> addEvent1(EventModel event) {
    event.id = getEventsCollection().doc().id;
    return getEventsCollection().doc().set(event);
  }
/* static void getEvents() {
    FirebaseFirestore.instance.collection(EventModel.collectionName).get().then((value) {
      value.docs.forEach((element) {});
    });
  } */
}
