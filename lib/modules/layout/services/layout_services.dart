import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LayoutServices {
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

  static Future<List<QueryDocumentSnapshot<EventModel>>> getEvents(
      String id) async {
    var ref = getCollectionRef();
    var data = id == "all"
        ? await ref.get()
        : await ref.where("categoryId", isEqualTo: id).get();
    return data.docs;
  }

  static Stream<QuerySnapshot<EventModel>> getEventsStream(String id) {
    var ref = getCollectionRef();
    var data = id == "all"
        ? ref.snapshots()
        : ref.where("categoryId", isEqualTo: id).snapshots();
    return data;
  }

  static Future<List<QueryDocumentSnapshot<EventModel>>> getFavorites() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    var ref = getCollectionRef();
    var data = await ref.where("usersFav", arrayContains: userId).get();
    return data.docs;
  }

  static Future<void> toggleFavorite(EventModel event) async {
    var ref = getCollectionRef();

    String userId = FirebaseAuth.instance.currentUser!.uid;
    if (event.usersFav.contains(userId)) {
      event.usersFav.remove(userId);
    } else {
      event.usersFav.add(userId);
    }

    ref.doc(event.id).set(event);
  }
}
