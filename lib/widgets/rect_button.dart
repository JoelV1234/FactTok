import 'package:biblereels/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class RectButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  const RectButton({super.key, 
    required this.onTap, 
    required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: const Color.fromARGB(255, 2, 108, 195),
        padding: EdgeInsets.symmetric(
          vertical: 7, horizontal: 16
        ),
        child: CustomText(
          text,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}