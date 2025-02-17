import 'package:biblereels/config.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Future<void> showDeleteCollectionDialog(
  BuildContext context, void Function() deleted) {
  
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const CustomText( color: black,
          'Delete Collection', fontWeight: FontWeight.bold,),
        content: const CustomText( color: black,
          'Are you sure you want to delete this collection?'),
        actions: <Widget>[
          TextButton(
            child: const CustomText('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const CustomText('Delete'),
            onPressed: () {
              Navigator.of(context).pop();
              deleted();
            },
          ),
        ],
      );
    },
  );
}