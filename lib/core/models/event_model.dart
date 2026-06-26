import 'package:firebase_auth/firebase_auth.dart';

class EventModel {
  String id;
  String categoryId;
  String title;
  String desc;
  String date;
  String time;
  String image;
  String userId;
  List<String> usersFav;
  bool isFavorite;

  EventModel(
      {required this.id,
      required this.categoryId,
      required this.userId,
      required this.title,
      required this.image,
      required this.time,
      this.usersFav = const [],
      this.isFavorite = false,
      required this.date,
      required this.desc});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "usersFav": usersFav,
      "categoryId": categoryId,
      "title": title,
      "desc": desc,
      "time": time,
      "date": date,
      "image": image
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    bool isFav = false;

    List<String> users = [];

    if (json["usersFav"] != null) {
      json["usersFav"].map((e) {
        users.add(e.toString());
      }).toList();
      isFav = users.contains(userId);
    }

    return EventModel(
        id: json["id"],
        userId: json["userId"],
        categoryId: json["categoryId"],
        time: json["time"],
        title: json["title"],
        image: json["image"],
        date: json["date"],
        usersFav: users,
        isFavorite: isFav,
        desc: json["desc"]);
  }
}
