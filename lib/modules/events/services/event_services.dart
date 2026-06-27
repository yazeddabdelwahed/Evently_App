import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/models/event_model.dart';

class EventServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference<EventModel> getCollectionRef() {
    return firestore.collection("events").withConverter(
      fromFirestore: (snapshot, options) {
        return EventModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    );
  }

  static Future<void> addEvent(EventModel eventModel) async {
    var ref = getCollectionRef();
    var doc = ref.doc();
    eventModel.id = doc.id;
    doc.set(eventModel);
  }

  static Future<void> deleteEvent(String id) async {
    var ref = getCollectionRef();
    var doc = ref.doc(id);
    await doc.delete();
  }

  static Future<void> updateEvent(EventModel event) async {
    var ref = getCollectionRef();
    var doc = ref.doc(event.id);
    await doc.update(event.toJson());
  }
}
