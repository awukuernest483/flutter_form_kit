import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData? suffixIcon;
  final String text;
  final TextStyle? style;
  final Function() onTap;
  final Color themeColor;

  const CustomButton(
      {super.key,
      this.suffixIcon,
      required this.text,
      required this.style,
      required this.onTap, required this.themeColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
            foregroundColor: Colors.white,
            backgroundColor: themeColor),
        onPressed: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: style,
            ),
            if (suffixIcon != null) ...[
              const SizedBox(
                width: 4,
              ),
              Icon(suffixIcon!),
            ]
          ],
        ));
  }
}
