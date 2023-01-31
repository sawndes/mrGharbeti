import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/screens/all_listings.dart';
import 'package:mr_gharbeti/src/widgets/authentication/database_methods.dart';
import 'package:mr_gharbeti/src/widgets/authentication/fire_auth.dart';
import '../controller/add_listings_controller.dart';
import '../models/user_model.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import 'package:image_picker/image_picker.dart';

class AddListingsPage extends StatefulWidget {
  const AddListingsPage({super.key});

  @override
  State<AddListingsPage> createState() => _AddListingsPageState();
}

class _AddListingsPageState extends State<AddListingsPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? imgUrl;

  Future getImage(bool isCamera) async {
    XFile? image;
    if (isCamera) {
      image = await _picker.pickImage(source: ImageSource.camera);
    } else {
      image = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = File(image!.path);
    });
  }

  // Future<String> _uploadImage(File? imageFile) async {
  //   if (imageFile == null) return "Null file";
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  //   final storageRef = FirebaseStorage.instance.ref().child(fileName);
  //   await storageRef.putFile(imageFile);
  //   // await uploadTask.then(()=>);
  //   String imageURL = await storageRef.getDownloadURL();

  //   return imageURL;
  //   // ...
  // }
  Future<String> _uploadImage(File? imageFile) async {
    // if (imageFile == null) return "Null file";
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    final storageRef = FirebaseStorage.instance.ref().child(fileName);
    // print(imageFile);
    await storageRef.putFile(imageFile!);
    // // await uploadTask.then(()=>);
    String imageURL = await storageRef.getDownloadURL();
    imgUrl = imageURL;
    return imageURL;
    // ...
  }

  @override
  Widget build(BuildContext context) {
    String thisUser = FireAuth.instance.user.uid;
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
                            child: FloatingActionButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: 150,
                                        child: Column(
                                          children: <Widget>[
                                            ListTile(
                                              leading: Icon(Icons.camera_alt),
                                              title: Text('Take a photo'),
                                              onTap: () {
                                                getImage(true);
                                                // _pickImage(ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            ListTile(
                                              leading:
                                                  Icon(Icons.photo_library),
                                              title:
                                                  Text('Choose from gallery'),
                                              onTap: () {
                                                // _pickImage(ImageSource.gallery);
                                                getImage(false);
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    });
                              },
                              // tooltip: 'Add photo',
                              child: Icon(Icons.add_a_photo),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                await _uploadImage(_image);
                                // print('object');
                                // print(FireAuth.instance.user.uid);
                                // addListings();
                                // print(imgUrl);
                                AddListingsController.instance.addListings(
                                  controller.title,
                                  controller.heading,
                                  controller.subheading,
                                  controller.description,
                                  imgUrl!,
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
