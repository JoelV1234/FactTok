import 'package:biblereels/config.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:flutter/material.dart';

class MoreInfoWidget extends StatelessWidget {
  final Fact fact;
  const MoreInfoWidget({super.key, required this.fact});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            CustomText(
              fact.title,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: black,
            ),
            CustomText(
              color: black,
              fact.description,
              fontSize: 16,
            ),
          ],
        ),
      ),
    );  
  }
}



Future<void> showMoreInfoDialog(
  BuildContext context,
  Fact fact
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return MoreInfoWidget(
          fact: fact
      
      );
    },
  );
}