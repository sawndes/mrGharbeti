import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/add_bills.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

class LandlordBills extends StatelessWidget {
  const LandlordBills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUI('Bills', true),
      body: const Center(
        child: Text('There is no bills added!'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddBillsPage());
        },
        label: const Text('Add Bills'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}
