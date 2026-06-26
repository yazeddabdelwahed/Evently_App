import 'package:evently_c16_online/core/constant/categorys.dart';
import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:evently_c16_online/modules/events/services/event_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EventProvider extends ChangeNotifier {
  int tabIndex = 0;
  DateTime? selectedDateTime;
  TimeOfDay? timeOfDay;
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void onTabChange(int index) {
    tabIndex = index;
    notifyListeners();
  }

  void onSelectedDate(DateTime dateTime) {
    selectedDateTime = dateTime;
    notifyListeners();
  }

  void onSelectedTime(TimeOfDay time) {
    timeOfDay = time;
    notifyListeners();
  }

  Future<void> addEvent(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    var event = EventModel(
        id: "id",
        userId: FirebaseAuth.instance.currentUser!.uid,
        categoryId: CategoryData.categories[tabIndex].id,
        title: titleController.text,
        image: CategoryData.categories[tabIndex].image,
        time: timeOfDay!.format(context),
        date: selectedDateTime.toString(),
        desc: descriptionController.text);
    await EventServices.addEvent(event);
    isLoading = false;
    notifyListeners();
    Navigator.pop(context);
  }
}
