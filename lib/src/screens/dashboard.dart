import 'package:flutter/material.dart';
import '../widgets/dashboard_widgets/categories_ui.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';

import '../widgets/dashboard_widgets/banner_ui.dart';
import '../widgets/dashboard_widgets/searchBar_ui.dart';
import '../widgets/dashboard_widgets/top_listings_ui.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBarUI(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to Dashboard',
                style: textTheme.bodyText2,
              ),
              Text(
                'Explore Listings',
                style: textTheme.headline2,
              ),
              const SizedBox(
                height: 20,
              ),
              //Search Bar
              DashboardSearchbarUI(textTheme: textTheme),
              const SizedBox(
                height: 20,
              ),
              DashBoardCategories(
                textTheme: textTheme,
              ),
              const SizedBox(
                height: 20,
              ),
              //Banner
              DashboardBannerUI(textTheme: textTheme),
              DashboardTopListings(textTheme: textTheme),
            ],
          ),
        ),
      ),
    );
  }
}
