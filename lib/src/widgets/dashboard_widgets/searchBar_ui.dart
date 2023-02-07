import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/search_page.dart';

class DashboardSearchbarUI extends StatefulWidget {
  const DashboardSearchbarUI({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  State<DashboardSearchbarUI> createState() => _DashboardSearchbarUIState();
}

class _DashboardSearchbarUIState extends State<DashboardSearchbarUI> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => SearchPage(textTheme: widget.textTheme));
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(width: 4),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search...',
              style: widget.textTheme.headline2
                  ?.apply(color: Colors.grey.withOpacity(0.5)),
            ),
            // const Icon(
            //   Icons.mic,
            //   size: 25,
            // )
          ],
        ),
      ),
    );
  }
}
