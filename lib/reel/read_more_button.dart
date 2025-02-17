import 'package:biblereels/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ReadMoreButton extends StatelessWidget {
  final Function() onPress;
  const ReadMoreButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: SizedBox(
        height: 50,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
                'Read More',
                fontSize: 18,
                fontWeight: FontWeight.bold,
            ),
            SizedBox(width: 10,),
            Icon(Icons.arrow_forward, color: Colors.white,)
          ],
        ),
      ),
    );
  }
}