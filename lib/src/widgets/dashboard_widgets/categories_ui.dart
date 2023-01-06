import 'package:flutter/material.dart';

import '../../models/categories_model.dart';

class DashBoardCategories extends StatelessWidget {
  const DashBoardCategories({Key? key, required this.textTheme})
      : super(key: key);
  final TextTheme textTheme;
  // final String title;
  // final String heading;
  // final String subheading;
  // final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDark = brightness == Brightness.dark;
    final list = DashboardCategoriesModel.list;
    return SizedBox(
      height: 45,
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: list[index].onPress,
          child: SizedBox(
            width: 170,
            height: 45,
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 45,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff000000)),
                  child: Center(
                    child: Text(list[index].title,
                        style: textTheme.headline6?.apply(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(list[index].heading,
                          style: textTheme.headline6,
                          overflow: TextOverflow.ellipsis),
                      // Text(list[index].subHeading, style: textTheme.bodyText2, overflow: TextOverflow.ellipsis)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
