import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  String location = "";
  LatLng? selectedLocation;
  Future<void> changeLocation(LatLng? position) async {
    if (position == null) {
      return;
    }
    selectedLocation = position;
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {}
    var first = placemarks.first;
    location = "${first.country} ${first.name}";
    notifyListeners();
  }
}
