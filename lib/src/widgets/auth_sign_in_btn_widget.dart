import 'package:flutter/material.dart';

class SignInAllButtons extends StatelessWidget {
  const SignInAllButtons({
    required this.btnIcon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Icon(
              btnIcon,
              // Icons.mail_outline_rounded,
              size: 50,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // 'Email',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  subtitle,
                  // 'Reset via Email verification',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
