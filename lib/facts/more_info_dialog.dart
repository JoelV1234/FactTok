import 'package:biblereels/widgets/rect_button.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:flutter/material.dart';

class MoreInfoDialog extends StatelessWidget {
  final Fact fact;
  const MoreInfoDialog({super.key, required this.fact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        25, 30, 25, 20),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            CustomText(
              fact.title,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            SizedBox(height: 10),
            CustomText(
              color: Colors.black,
              fact.description,
              fontSize: 16,
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: RectButton(
                text: 'Close',
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
          ]
      ),
    );  
  }
}


void showMoreInfoDialog(
  BuildContext context,
  Fact fact
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5)
          )
        ),
        child: SizedBox(
          width: 400,
          child: MoreInfoDialog(
            fact: fact
          ),
        ),
      );
    },
  );
}

void showMoreInfoModal(
  BuildContext context,
  Fact fact
) async {
  return showModalBottomSheet<void>(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0.0)
      )
    ),
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: 40
        ),
        child: MoreInfoDialog(
          fact: fact
        ),
      );
    },
  );
}



void showMoreInfo(
  BuildContext context,
  Fact fact
) {
  bool isSmallScreen = MediaQuery.of(context).size.width < 600;
  return isSmallScreen
    ? showMoreInfoModal(context, fact)
    : showMoreInfoDialog(context, fact);
}