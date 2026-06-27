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

  Future<void> deleteEvent(String id) async {
    return EventServices.deleteEvent(id);
  }

  void setEvent(EventModel event) {
    var index = CategoryData.categories
        .indexWhere((category) => category.id == event.categoryId);
    if (index != -1) {
      tabIndex = index;
    }
    selectedDateTime = DateTime.parse(event.date);

    timeOfDay = TimeOfDay(
        hour: selectedDateTime!.hour,
        minute: selectedDateTime!.minute
    );

    titleController.text = event.title;
    descriptionController.text = event.desc;
  }

  Future<void> updateEvent(EventModel eventModel, BuildContext context) async {
    eventModel.desc = descriptionController.text;
    eventModel.title = titleController.text;
    eventModel.categoryId = CategoryData.categories[tabIndex].id;
    eventModel.image = CategoryData.categories[tabIndex].image;
    if (timeOfDay != null) {
      eventModel.time = timeOfDay!.format(context);
    }
    if (selectedDateTime != null) {
      eventModel.date = DateTime(
              selectedDateTime!.year,
              selectedDateTime!.month,
              selectedDateTime!.day,
              timeOfDay?.hour ?? 0,
              timeOfDay?.minute ?? 0)
          .toString();
      await EventServices.updateEvent(eventModel);
    }
  }
}
