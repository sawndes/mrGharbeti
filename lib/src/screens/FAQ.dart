import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class FAQPage extends StatelessWidget {
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
      body: ListView(
        children: const <Widget>[
          FAQItem(
            question: 'How do I add a listing?',
            answer:
                'To add a listing, go to the "Add Listing" section in the app and provide all the required information about the house/apartment you want to rent. Once you submit the details, your listing will be available for other users to view.',
          ),
          FAQItem(
            question: 'Can I chat with the listing owners?',
            answer:
                'Yes, you can! Once you find a listing you are interested in, you can open the listing details and there will be an option to start a chat with the listing owner. This way, you can communicate and discuss any further details or arrange a viewing.',
          ),
          FAQItem(
            question: 'How can I access the landlord or tenant portal?',
            answer:
                'To access the landlord or tenant portal, log in to your MrGharbeti account and navigate to the corresponding portal section. There, you will find all the features and functionalities specific to landlords or tenants.',
          ),
          FAQItem(
            question: 'Can I add my bills in the app?',
            answer:
                'Yes, you can add your bills through the app. In the tenant portal, there will be an option to add bills where you can provide details such as the bill type, amount, and due date. This will help you keep track of your expenses.',
          ),
          FAQItem(
            question: 'How can landlords notify tenants for payments?',
            answer:
                'Landlords can notify tenants for payments through the app. In the landlord portal, there will be a feature to send payment reminders or notifications to the tenants. This will help ensure timely payments and better communication between landlords and tenants.',
          ),
        ],
      ),
    );
  }
}

class FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const FAQItem({Key? key, required this.question, required this.answer})
      : super(key: key);

  @override
  _FAQItemState createState() => _FAQItemState();
}

class _FAQItemState extends State<FAQItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(widget.answer),
          ),
        ],
        onExpansionChanged: (value) {
          setState(() {
            _expanded = value;
          });
        },
        initiallyExpanded: _expanded,
      ),
    );
  }
}
