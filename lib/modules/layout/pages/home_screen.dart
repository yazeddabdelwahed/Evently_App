import 'package:evently_c16_online/core/constant/categorys.dart';
import 'package:evently_c16_online/core/provider/app_provider.dart';
import 'package:evently_c16_online/core/theme/app_colors.dart';
import 'package:evently_c16_online/main.dart';
import 'package:evently_c16_online/modules/layout/manager/layout_provider.dart';
import 'package:evently_c16_online/modules/layout/services/layout_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/routes/app_route_name.dart';
import '../../events/event_details/event_details.dart';
import '../widgets/event_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Consumer<LayoutProvider>(
      builder: (context, provider, child) {
        return Column(
          children: [
            Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24))),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome Back ✨",
                                  style: theme.textTheme.bodyMedium!.copyWith(
                                      color: theme.scaffoldBackgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  provider.user.displayName?.toUpperCase() ??
                                      "",
                                  style: theme.textTheme.titleLarge!.copyWith(
                                      color: theme.scaffoldBackgroundColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            appProvider.themeMode == ThemeMode.light
                                ? "assets/icons/light.png"
                                : "assets/icons/dark.png",
                            color: Colors.white,
                            width: 36,
                            height: 36,
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Colors.white,
                            ),
                            child: Text(
                              appProvider.locale.toUpperCase(),
                              style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Iconsax.location_outline,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Cairo",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: theme.scaffoldBackgroundColor,
                            ),
                          ),
                        ],
                      ),
                      DefaultTabController(
                          length: CategoryData.categoriesWithAll.length,
                          child: TabBar(
                              onTap: provider.onTabIndexChange,
                              dividerColor: Colors.transparent,
                              indicatorColor: Colors.transparent,
                              indicatorPadding: const EdgeInsets.all(4),
                              labelPadding: const EdgeInsets.all(4),
                              tabAlignment: TabAlignment.start,
                              labelStyle: theme.textTheme.bodyMedium!
                                  .copyWith(color: AppColors.primaryColor),
                              unselectedLabelColor: AppColors.lightColor,
                              isScrollable: true,
                              tabs: CategoryData.categoriesWithAll.map(
                                (e) {
                                  int index =
                                      CategoryData.categoriesWithAll.indexOf(e);
                                  bool isSelected = index == provider.tabIndex;
                                  return Tab(
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: isSelected ? Colors.white : null,
                                        border: Border.all(color: Colors.white),
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
                    ],
                  ),
                )),
            Expanded(
              child: StreamBuilder(
                stream: LayoutServices.getEventsStream(
                    CategoryData.categoriesWithAll[provider.tabIndex].id),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    var events = snapshot.data?.docs ?? [];
                    return ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: events?.length ?? 0,
                      itemBuilder: (context, index) {
                        var event = events![index].data();
                        return EventWidget(
                          event: event,
                          onTapFav: () {
                            provider.toggleFavorite(event);
                          },
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.eventDetails, arguments: event);
                          },
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
