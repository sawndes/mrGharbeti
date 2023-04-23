import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

class BillView extends StatefulWidget {
  const BillView({super.key});

  @override
  State<BillView> createState() => _BillViewState();
}

class _BillViewState extends State<BillView> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme;
    var arguments = Get.arguments;
    return Scaffold(
      appBar: AppBarUI(arguments['bill_name'], true),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  arguments['bill_photo'].length == 1
                      ? Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(16),
                            image: DecorationImage(
                              image: NetworkImage(arguments['bill_photo'][0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : CarouselSlider.builder(
                          itemCount: arguments['bill_photo'].length,
                          options: CarouselOptions(
                              height: 300,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentPos = index;
                                });
                              }),
                          itemBuilder: (context, index, x) {
                            // listPaths.add(arguments['listing_photo']);

                            return MyImageView(arguments['bill_photo'][index]);
                          },
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // children: [
                    //   arguments['listing_photo'].map((url) {
                    //     int index = listPaths.indexOf(url);
                    //   })
                    // ],
                    children: arguments['bill_photo'].map<Widget>((url) {
                      int index = arguments['bill_photo'].indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentPos == index
                              ? const Color.fromRGBO(0, 0, 0, 0.9)
                              : const Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                arguments['description'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                arguments['bill_name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rs ${arguments['bill_price']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        // color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imgPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
