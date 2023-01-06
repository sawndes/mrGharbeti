import 'package:flutter/material.dart';

class DashboardSearchbarUI extends StatelessWidget {
  const DashboardSearchbarUI({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: 4),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search...',
            style:
                textTheme.headline2?.apply(color: Colors.grey.withOpacity(0.5)),
          ),
          const Icon(
            Icons.mic,
            size: 25,
          )
        ],
      ),
    );
  }
}
