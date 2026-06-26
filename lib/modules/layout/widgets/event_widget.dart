import 'package:animate_do/animate_do.dart';
import 'package:evently_c16_online/core/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';

class EventWidget extends StatelessWidget {
  final EventModel event;
  final VoidCallback onTapFav; // Changed to final VoidCallback for safety
  final VoidCallback onTap;    // 👇 Added the new onTap callback

  const EventWidget({
    super.key,
    required this.event,
    required this.onTapFav,
    required this.onTap,       // 👇 Required in constructor
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // 👇 Wrapped the layout in an InkWell to make the entire card clickable
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16), // Keeps the ripple effect within bounds
      child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primaryColor),
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(event.image))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text(
                      DateFormat("d").format(DateTime.parse(event.date)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 20),
                    ),
                    Text(
                      DateFormat("MMM").format(DateTime.parse(event.date)),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Text(
                      event.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkColor,
                          fontSize: 20),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        onTapFav();
                      },
                      child: Icon(
                        event.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    ZoomIn(
                      child: Text(
                        event.usersFav.length.toString(),
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}