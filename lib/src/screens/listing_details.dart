import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_gharbeti/src/widgets/dashboard_widgets/appBar_ui.dart';

class ListingDetail extends StatelessWidget {
  const ListingDetail(this.textTheme, {super.key});
  final TextTheme textTheme;
  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    return Scaffold(
      appBar: AppBarUI(arguments.title, true),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              arguments.heading,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              arguments.description,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                Text(
                  arguments.description,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs 10000 per month',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_border_outlined),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment,
                  children: [
                    SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Rent'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 100,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: const Text('Chat'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
