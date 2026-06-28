import 'package:flutter/material.dart';

class EventMap extends StatefulWidget {
  const EventMap({super.key});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Enable your location")),
    );
  }
  Future<void> getLocation() async{

  }
}
