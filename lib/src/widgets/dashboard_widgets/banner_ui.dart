import 'package:flutter/material.dart';

class DashboardBannerUI extends StatelessWidget {
  const DashboardBannerUI({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  // final bool isDark;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1st banner
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //For Dark Color
              color: isDark ? Color(0xFF272727) : Color(0xFFF7F6F1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          print('clicked');
                        },
                        child: Icon(Icons.bookmark_border),
                      ),
                    ),
                    // ElevatedButton.icon(
                    //   style: ButtonStyle(
                    //     backgroundColor: Colors.white
                    //   ),
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.bookmark_border,
                    //       size: 10,
                    //     ),
                    //     label: Text('')),
                    const Flexible(
                        child:
                            // Icon(Icons.house)
                            Image(
                                image:
                                    AssetImage('assets/images/login_ui.png'))),
                  ],
                ),
                const SizedBox(height: 25),
                Text('1 BHK Room',
                    style: textTheme.headline4,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Text('Naxal-8, Kathmandu',
                    style: textTheme.bodyText2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        //2nd Banner
        Expanded(
          child: Column(
            children: [
              //Card
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  //For Dark Color
                  color: isDark ? Color(0xFF272727) : Color(0xFFF7F6F1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(child: Icon(Icons.bookmark_border)),
                        Flexible(
                            child: Image(
                                image:
                                    AssetImage('assets/images/login_ui.png'))),
                      ],
                    ),
                    Text('3BHK Apartment',
                        style: textTheme.headline4,
                        overflow: TextOverflow.ellipsis),
                    Text('Banepa-7, Kavre',
                        style: textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                      onPressed: () {}, child: const Text('View All')),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
