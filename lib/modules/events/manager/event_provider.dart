import 'package:evently_c16_online/core/constant/categorys.dart';
import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:evently_c16_online/modules/events/services/event_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding
import '../../../core/provider/location_provider.dart';

class EventProvider extends ChangeNotifier {
  int tabIndex = 0;
  DateTime? selectedDateTime;
  TimeOfDay? timeOfDay;
  bool isLoading = false;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // FIX: LocationProvider must be initialized, usually passed from the UI or via ProxyProvider
  LocationProvider locationProvider;

  EventProvider({required this.locationProvider});

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

  // Helper method to get address from Lat/Lng
  Future<String> getLocationAddress(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Returns something like: "Cairo, Egypt" or "Maadi, Cairo"
        return "${place.locality}, ${place.country}";
      }
    } catch (e) {
      print("Geocoding error: $e");
    }
    return "Unknown Location";
  }

  Future<void> addEvent(BuildContext context) async {
    if (selectedDateTime == null || timeOfDay == null) {
      // Add validation logic here (Toast or SnackBar)
      return;
    }

    isLoading = true;
    notifyListeners();

    // 1. Get coordinates from the provider
    double lat = locationProvider.selectedLocation?.latitude ?? 0.0;
    double lng = locationProvider.selectedLocation?.longitude ?? 0.0;

    // 2. Use geocoding to get the real address name
    String address = await getLocationAddress(lat, lng);

    var event = EventModel(
        id: "", // Service usually generates the ID
        userId: FirebaseAuth.instance.currentUser!.uid,
        categoryId: CategoryData.categories[tabIndex].id,
        title: titleController.text,
        image: CategoryData.categories[tabIndex].image,
        time: timeOfDay!.format(context),
        date: selectedDateTime.toString(),
        desc: descriptionController.text,
        lat: lat,
        lng: lng,
        locationName: address // REAL ADDRESS instead of hardcoded
    );

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
    isLoading = true;
    notifyListeners();

    eventModel.desc = descriptionController.text;
    eventModel.title = titleController.text;
    eventModel.categoryId = CategoryData.categories[tabIndex].id;
    eventModel.image = CategoryData.categories[tabIndex].image;

    // Update location if the user changed it in the map
    if (locationProvider.selectedLocation != null) {
      eventModel.lat = locationProvider.selectedLocation!.latitude;
      eventModel.lng = locationProvider.selectedLocation!.longitude;
      eventModel.locationName = await getLocationAddress(eventModel.lat, eventModel.lng);
    }

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
    }

    await EventServices.updateEvent(eventModel);

    isLoading = false;
    notifyListeners();
  }
}