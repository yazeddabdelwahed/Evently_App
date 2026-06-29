import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:evently_c16_online/core/provider/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class EventMap extends StatefulWidget {
  final LocationProvider locationProvider;
  final EventModel?
      eventModel;

  const EventMap({super.key, required this.locationProvider, this.eventModel});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  bool isLocationDetected = false;
  late LocationData locationData;
  late GoogleMapController googleMapController;
  LatLng? selectedLatLng;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    if (widget.eventModel != null && widget.eventModel!.lat != 0.0) {

      isLocationDetected = true;
      selectedLatLng = LatLng(widget.eventModel!.lat, widget.eventModel!.lng);
      markers.add(Marker(
        markerId: const MarkerId("event_loc"),
        position: selectedLatLng!,
      ));
    } else {
      // If picking a new location
      getLocation().then((value) => setState(() {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isReadOnly = widget.eventModel != null;

    return Scaffold(
      appBar: isReadOnly ? AppBar(title: Text(widget.eventModel!.title)) : null,
      body: isLocationDetected
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  onMapCreated: (controller) =>
                      googleMapController = controller,
                  onTap: isReadOnly
                      ? null
                      : (position) {
                          markers.clear();
                          markers.add(Marker(
                              markerId: const MarkerId("2"),
                              position: position));
                          selectedLatLng = position;
                          setState(() {});
                        },
                  initialCameraPosition: CameraPosition(
                      target: selectedLatLng ??
                          LatLng(locationData.latitude ?? 0,
                              locationData.longitude ?? 0),
                      zoom: 14.5),
                  markers: markers,
                ),
                if (!isReadOnly) // Only show button if picking a location
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedLatLng != null) {
                          await widget.locationProvider
                              .changeLocation(selectedLatLng!);
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text("Confirm Location",
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> getLocation() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    locationData = await location.getLocation();
    setState(() {
      isLocationDetected = true;
      selectedLatLng = LatLng(locationData.latitude!, locationData.longitude!);
      markers.add(
          Marker(markerId: const MarkerId("1"), position: selectedLatLng!));
    });
  }
}
