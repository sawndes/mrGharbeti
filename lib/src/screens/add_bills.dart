import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/controller/add_bills_controller.dart';
import 'package:mr_gharbeti/src/widgets/authentication/fire_auth.dart';
import '../controller/add_listings_controller.dart';
import '../widgets/dashboard_widgets/appBar_ui.dart';
import 'package:image_picker/image_picker.dart';

class AddBillsPage extends StatefulWidget {
  const AddBillsPage({super.key});

  @override
  State<AddBillsPage> createState() => _AddBillsPageState();
}

class _AddBillsPageState extends State<AddBillsPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? imgUrl;
  List<String>? imgUrls = [];
  List<File>? _images;

  Future getImage(bool isCamera) async {
    XFile? image;
    List<XFile>? imagefiles;
    if (isCamera) {
      // List<XFile>? camPhoto;
      // image = (await _picker.pickImage(source: ImageSource.camera));
      // camPhoto!.add(image!);
      // if (image != null) {
      //   // imagefiles!.add(image);
      //   imagefiles = camPhoto;
      //   // imagefiles = image;
      //   setState(() {});
      // } else {
      //   print("No image is selected.");
      // }
      // _picker.pickMultiImage()
      // imagecourse
    } else {
      var pickedfiles = await _picker.pickMultiImage();
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
      // image = await _picker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _images = imagefiles!.map((img) => File(img.path)).toList();
      // _image = File(image!.path);
    });
  }

  Future<List<String>> _uploadImages(List<File> imageFiles) async {
    if (imageFiles == null) return [];
    List<String> imageURLs = [];

    for (File imageFile in imageFiles) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      await storageRef.putFile(imageFile);
      String imageURL = await storageRef.getDownloadURL();
      imageURLs.add(imageURL);
    }

    imgUrls = imageURLs;
    return imageURLs;
  }

  @override
  Widget build(BuildContext context) {
    String thisUser = FireAuth.instance.user.uid;
    final size = MediaQuery.of(context).size;
    GlobalKey<FormState> _formKey = GlobalKey();
    final controller = Get.put(AddBillsController());
    return Scaffold(
        appBar: AppBarUI('Add your listings', false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
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
                            decoration: InputDecoration(
                              label: RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Bill Title',
                                        style: TextStyle(color: Colors.black)),
                                    TextSpan(
                                        text: ' *',
                                        style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                              ),
                              prefixIcon: Icon(Icons.title),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the title';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: controller.price,
                            decoration: const InputDecoration(
                              label: Text('Bill amount'),
                              prefixIcon: Icon(Icons.attach_money_outlined),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the amount';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: controller.description,
                            decoration: const InputDecoration(
                              label: Text('Bill Description'),
                              prefixIcon: Icon(Icons.description),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the Description';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 200,
                              child: OutlinedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Container(
                                          height: 80,
                                          child: Column(
                                            children: <Widget>[
                                              // ListTile(
                                              //   leading: Icon(Icons.camera_alt),
                                              //   title: Text('Take a photo'),
                                              //   onTap: () {
                                              //     getImage(true);
                                              //     // _pickImage(ImageSource.camera);
                                              //     Navigator.pop(context);
                                              //   },
                                              // ),

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
                                child: const Icon(Icons.add_a_photo),
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            padding: const EdgeInsets.symmetric(vertical: 50),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // if (_images == null) return [];
                                  // // await _uploadImage(_image);
                                  // List<String> imageUrls = [];
                                  // for (File image in _images!) {
                                  //   String imageUrl = await _uploadImages(image);
                                  //   imageUrls.add(imageUrl);
                                  // }
                                  await _uploadImages(_images!);
                                  // print('object');
                                  // print(FireAuth.instance.user.uid);
                                  // addListings();
                                  // print(imgUrl);
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    // AddListingsController.instance.addListings(
                                    //   controller.title,
                                    //   controller.price,
                                    //   controller.description,
                                    //   imgUrls!,
                                    // );
                                    AddBillsController.instance.addBills(
                                      controller.title,
                                      controller.price,
                                      controller.description,
                                      imgUrls!,
                                    );
                                  } else {
                                    Get.snackbar('Fill up the form',
                                        'Please fill in all required fields.');
                                    // showSnackBar(context,
                                    //     'Please fill in all required fields.');
                                  }
                                  // AddListingsController.instance.addListings(
                                  //   controller.title,
                                  //   controller.price,
                                  //   controller.address,
                                  //   controller.description,
                                  //   imgUrl!,
                                  // );
                                },
                                child: const Text('Add listings'),
                              ),
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
