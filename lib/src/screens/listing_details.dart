import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

class ListingDetail extends StatelessWidget {
  const ListingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    return Scaffold(
      appBar: AppBarUI(arguments.title, true),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(arguments.image),
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
