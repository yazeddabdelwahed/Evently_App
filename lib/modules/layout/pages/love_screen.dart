import 'package:evently_c16_online/modules/layout/manager/layout_provider.dart';
import 'package:evently_c16_online/modules/layout/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/categorys.dart';
import '../../../core/routes/app_route_name.dart';
import '../../../core/theme/app_colors.dart';
import '../../events/event_details/event_details.dart';
import '../services/layout_services.dart';

class LoveScreen extends StatelessWidget {
  const LoveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Love Screen"),
      ),
      body: Consumer<LayoutProvider>(
        builder: (context, provider, child) {
          return FutureBuilder(
            future: LayoutServices.getFavorites(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                var events = snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: events?.length ?? 0,
                  itemBuilder: (context, index) {
                    var event = events![index].data();
                    return EventWidget(event: event, onTapFav: () {
                      provider.toggleFavorite(event);
                    },
                      onTap: () {
                        Navigator.pushNamed(context, RouteName.eventDetails, arguments: event);
                      },
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        },
      ),
    );
  }
}
