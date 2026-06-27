import 'package:evently_c16_online/core/constant/categorys.dart';
import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:evently_c16_online/core/routes/app_route_name.dart';
import 'package:evently_c16_online/core/widgets/custom_btn.dart';
import 'package:evently_c16_online/modules/events/manager/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';

class EditEvent extends StatelessWidget {
  final EventModel eventModel;
  const EditEvent({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ChangeNotifierProvider(
        create: (context) => EventProvider()..setEvent(eventModel),
        child: Consumer<EventProvider>(
          builder: (context, provider, child) {
            return Scaffold(
              bottomNavigationBar: Container(
                padding: const EdgeInsets.all(12),
                child: CustomBtn(
                    onTap: () async {
                     await provider.updateEvent(eventModel, context);
                     Navigator.pushNamedAndRemoveUntil(context, RouteName.layout, (_)=> false);
                    },
                    text: "Update Event"),
              ),
              appBar: AppBar(
                title: const Text("Edit Event"),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        CategoryData.categories[provider.tabIndex].image,
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
                            onTap: provider.onTabChange,
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
                                bool isSelected = index == provider.tabIndex;
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
                                        Icon(
                                          Icons.sports,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColors.primaryColor,
                                          size: 18,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(e.name,
                                            style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : AppColors.primaryColor)),
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
                      controller: provider.titleController,
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
                        controller: provider.descriptionController,
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
                                    initialDate: provider.selectedDateTime,
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 60)))
                                .then(
                              (value) {
                                provider
                                    .onSelectedDate(value ?? DateTime.now());
                              },
                            );
                          },
                          child: Text(
                            provider.selectedDateTime == null
                                ? "Choose Date"
                                : DateFormat("y / M / d")
                                    .format(provider.selectedDateTime!),
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
                                        provider.timeOfDay ?? TimeOfDay.now())
                                .then(
                              (value) {
                                provider
                                    .onSelectedTime(value ?? TimeOfDay.now());
                              },
                            );
                          },
                          child: Text(
                            provider.timeOfDay == null
                                ? "Choose Time"
                                : provider.timeOfDay!.format(context),
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
