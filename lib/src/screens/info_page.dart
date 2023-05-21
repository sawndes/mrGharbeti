import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFF00BF6D).withOpacity(0.9),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            LineAwesomeIcons.angle_left,
            color: Colors.black,
          ),
        ),
        title: Text(
          'App Info',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome to MrGharbeti!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'About the App:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'MrGharbeti is a rental management system designed to make the process of finding, renting, and managing properties easier for both landlords and tenants. The app provides various features and functionalities to streamline the rental experience.',
              ),
              SizedBox(height: 16),
              Text(
                'Key Features:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Add and browse property listings\n'
                '2. Chat with listing owners\n'
                '3. Landlord and tenant portals\n'
                '4. Bill management\n'
                '5. Payment reminders\n'
                '6. And more!',
              ),
              SizedBox(height: 16),
              Text(
                'How to Use the App:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                '1. Create an account or log in to your existing account\n'
                '2. Browse through property listings\n'
                '3. Chat with the listing owners to discuss further details\n'
                '4. Use the landlord or tenant portal to access specific features\n'
                '5. Add bills and manage payments\n'
                '6. Stay updated with notifications and reminders\n'
                '7. Enjoy a seamless rental experience!',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
