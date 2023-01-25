import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/all_listings.dart';
import '../controller/add_listings_controller.dart';
import '../models/user_model.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';

class AddListingsPage extends StatelessWidget {
  const AddListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    GlobalKey<FormState> _formKey = GlobalKey();
    final controller = Get.put(AddListingsController());
    return Scaffold(
        appBar: AppBarUI('Add your listings', false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 15, left: 30, right: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            controller: controller.title,
                            decoration: const InputDecoration(
                              label: Text('Title'),
                              prefixIcon: Icon(Icons.title),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: controller.heading,
                            decoration: const InputDecoration(
                              label: Text('Heading'),
                              prefixIcon: Icon(Icons.text_increase_outlined),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            controller: controller.subheading,
                            decoration: const InputDecoration(
                              label: Text('Sub Heading'),
                              prefixIcon: Icon(Icons.text_rotate_up_rounded),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: controller.description,
                            decoration: const InputDecoration(
                              label: Text('Description'),
                              prefixIcon: Icon(Icons.description),
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                AddListingsController.instance.addListings(
                                  controller.title,
                                  controller.heading,
                                  controller.subheading,
                                  controller.description,
                                );
                              },
                              child: const Text('Add listings'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
