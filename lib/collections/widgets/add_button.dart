import 'package:biblereels/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final Function() onTap;
  const AddButton({super.key, required this.onTap});

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
          'Save',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}