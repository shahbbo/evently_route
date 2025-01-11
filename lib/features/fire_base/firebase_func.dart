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
  static Future<void> addEvent1(EventModel event) {
    var docRef = getEventsCollection().doc();
    event.id = docRef.id;
    return docRef.set(event);
  }
}
