import 'package:evently_c16_online/core/constant/categorys.dart';
import 'package:evently_c16_online/core/provider/location_provider.dart';
import 'package:evently_c16_online/core/widgets/custom_btn.dart';
import 'package:evently_c16_online/modules/events/manager/event_provider.dart';
import 'package:evently_c16_online/modules/events/pick_event_location/event_map.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Add this for LatLng
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  late LocationProvider locationProvider;

  @override
  void initState() {
    super.initState();
    locationProvider = LocationProvider();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => EventProvider(locationProvider: locationProvider)),
          ChangeNotifierProvider.value(value: locationProvider),
        ],
        child: Consumer2<EventProvider, LocationProvider>(
          builder: (context, eventProvider, locProvider, child) {
            return Scaffold(
              bottomNavigationBar: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  child: CustomBtn(
                      onTap: () {
                        eventProvider.addEvent(context);
                      },
                      text: "Add Event"),
                ),
              ),
              appBar: AppBar(
                title: const Text("Add Event"),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        CategoryData.categories[eventProvider.tabIndex].image,
                        excludeFromSemantics: true,
                        gaplessPlayback: true,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    DefaultTabController(
                        length: CategoryData.categories.length,
                        child: TabBar(
                            onTap: eventProvider.onTabChange,
                            dividerColor: Colors.transparent,
                            indicatorColor: Colors.transparent,
                            indicatorPadding: const EdgeInsets.all(4),
                            labelPadding: const EdgeInsets.all(4),
                            tabAlignment: TabAlignment.start,
                            labelStyle: theme.textTheme.bodyMedium!
                                .copyWith(color: AppColors.lightColor),
                            unselectedLabelColor: AppColors.primaryColor,
                            isScrollable: true,
                            tabs: CategoryData.categories.map(
                                  (e) {
                                int index = CategoryData.categories.indexOf(e);
                                bool isSelected = index == eventProvider.tabIndex;
                                return Tab(
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.primaryColor
                                          : null,
                                      border: Border.all(
                                          color: AppColors.primaryColor),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.sports,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(e.name),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ).toList())),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text("Title"),
                    TextFormField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                      controller: eventProvider.titleController,
                      decoration: const InputDecoration(
                          prefixIcon:
                          ImageIcon(AssetImage("assets/icons/note.png")),
                          hintText: "Event Title",
                          hintStyle:
                          TextStyle(fontSize: 18, color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    const Text("Description"),
                    SizedBox(
                      height: 120,
                      child: TextFormField(
                        onTapOutside: (event) {
                          FocusManager.instance.primaryFocus!.unfocus();
                        },
                        controller: eventProvider.descriptionController,
                        textAlignVertical: TextAlignVertical.top,
                        maxLines: null,
                        expands: true,
                        decoration: const InputDecoration(
                            hintText: "Event Description",
                            hintStyle:
                            TextStyle(fontSize: 18, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Event Date : "),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                initialDate: eventProvider.selectedDateTime,
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 60)))
                                .then(
                                  (value) {
                                eventProvider
                                    .onSelectedDate(value ?? DateTime.now());
                              },
                            );
                          },
                          child: Text(
                            eventProvider.selectedDateTime == null
                                ? "Choose Date"
                                : DateFormat("y / M / d")
                                .format(eventProvider.selectedDateTime!),
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Event Time : "),
                        InkWell(
                          onTap: () {
                            showTimePicker(
                                context: context,
                                initialTime:
                                eventProvider.timeOfDay ?? TimeOfDay.now())
                                .then(
                                  (value) {
                                eventProvider
                                    .onSelectedTime(value ?? TimeOfDay.now());
                              },
                            );
                          },
                          child: Text(
                            eventProvider.timeOfDay == null
                                ? "Choose Time"
                                : eventProvider.timeOfDay!.format(context),
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // 👇 Added Event Location Row Here
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=> EventMap(locationProvider: locProvider,)));
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
                                  weight: 35,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                locProvider.location.isEmpty ? "location" : locProvider.location..trim(),
                                style: GoogleFonts.inter(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Event Location : "),
                    //     InkWell(
                    //       onTap: () {
                    //         // TODO: Replace this dummy coordinate with the actual logic
                    //         // to open a Map screen or get the user's current location.
                    //         // For now, this tests the provider with New Cairo coordinates.
                    //         locProvider.changeLocation(const LatLng(30.0300, 31.4700));
                    //       },
                    //       child: Text(
                    //         locProvider.location.isEmpty
                    //             ? "Choose Location"
                    //             : locProvider.location,
                    //         style: TextStyle(
                    //             color: AppColors.primaryColor,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}