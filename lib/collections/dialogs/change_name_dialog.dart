import 'package:biblereels/collections/models/collection_view_model.dart';
import 'package:biblereels/widgets/rect_button.dart';
import 'package:biblereels/config.dart';
import 'package:flutter/material.dart';

class ChangeNameDialog extends StatefulWidget {
  final CollectionViewModel collection;
  const ChangeNameDialog({super.key, required this.collection});

  @override
  State<ChangeNameDialog> createState() => _ChangeNameDialogState();
}

class _ChangeNameDialogState extends State<ChangeNameDialog> {

  late TextEditingController nameController; 
  late CollectionViewModel collection;

  @override
  void initState() {
    collection = widget.collection;
    nameController = TextEditingController(
      text: collection.collectionName
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: const RoundedRectangleBorder(  
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Change collection Name', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold,
              color: Colors.black),),
            SizedBox(height: 9,),
            TextField(
              style: TextStyle(color: black),
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 13,),
            Align(
              alignment: Alignment.bottomRight,
              child: RectButton(
                text: 'Save',
                onTap: () {
                  collection.changeName(nameController.text);
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showChangeNameDialog(
  BuildContext context,
  CollectionViewModel collection
) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return ChangeNameDialog(
        collection: collection
      );
    },
  );
}