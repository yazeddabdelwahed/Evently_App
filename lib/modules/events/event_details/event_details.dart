import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:evently_c16_online/modules/events/manager/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/constant/categorys.dart';
import '../../../core/routes/app_route_name.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/provider/location_provider.dart';

class EventDetails extends StatelessWidget {
  final EventModel eventModel;
  const EventDetails({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EventProvider(locationProvider: LocationProvider()),
      child: Consumer<EventProvider>(
        builder: (context, provider, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Event Details',
              style: GoogleFonts.roboto(color: AppColors.primaryColor),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.editEvent,
                      arguments: eventModel);
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () async {
                  await provider.deleteEvent(eventModel.id);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete, color: Colors.redAccent),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    eventModel.image,
                    excludeFromSemantics: true,
                    gaplessPlayback: true,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  eventModel.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(Icons.calendar_month,
                              color: Colors.white)),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${eventModel.date.substring(8, 10)} ${getMonthName(eventModel.date.substring(5, 7))} ${eventModel.date.substring(0, 4)} ',
                            style: GoogleFonts.inter(
                                color: AppColors.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            eventModel.time,
                            style: GoogleFonts.inter(
                                color: AppColors.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.eventMap,
                        arguments: eventModel);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.primaryColor, width: 1),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.white,
                            )),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            eventModel.locationName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                color: AppColors.primaryColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: AppColors.primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description:',
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      eventModel.desc,
                      style: GoogleFonts.inter(
                          fontSize: 16, color: AppColors.primaryColor),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getMonthName(String monthNum) {
    List<String> shortMonths = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return shortMonths[int.parse(monthNum) - 1];
  }
}
