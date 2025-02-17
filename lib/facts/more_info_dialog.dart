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
        20, 15, 20, 30),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  fact.title,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                Expanded(child: Container()),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            CustomText(
              color: Colors.black,
              fact.description,
              fontSize: 16,
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
        child: MoreInfoDialog(
          fact: fact
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