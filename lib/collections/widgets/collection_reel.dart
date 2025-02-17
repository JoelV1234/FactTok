import 'dart:math';

import 'package:biblereels/collections/dialogs/change_name_dialog.dart';
import 'package:biblereels/collections/models/collection_view_model.dart';
import 'package:biblereels/collections/dialogs/delete_collection_dialog.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/reel/reel_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CollectionReel extends StatefulWidget {
  final Function() onDelete;
  const CollectionReel({super.key, required this.onDelete});

  @override
  State<CollectionReel> createState() => _CollectionReelState();
}

class _CollectionReelState extends State<CollectionReel> {
  late Fact selectedFact;
  int currentIndex = 0;

  @override
  void initState() {
    selectedFact = context.read<CollectionViewModel>().getFacts().first;
    super.initState();
  }

  void removeFact() {
    final collection = context.read<CollectionViewModel>();
    if(collection.facts.length == 1) {
      showDeleteCollectionDialog(context, () {
        widget.onDelete();
        WidgetsBinding.instance.addPostFrameCallback((_) =>
        Navigator.pop(context));
      });
    } else {
      setState(() {
        collection.removeFact(selectedFact);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CollectionViewModel collection = context.watch<CollectionViewModel>();
    return Scaffold(
      body:  Stack(
        children: [
          ReelScreen(
            initialIndex: min(currentIndex, collection.facts.length - 1),
            facts: collection.getFacts(),
            onNewFact: (fact, index) =>
              setState(() {
                selectedFact = fact;
                currentIndex = index;
              })
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                    color: Colors.white,),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10),
                  CustomText(
                    collection.collectionName,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  Expanded(child: Container()),
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () => showChangeNameDialog(
                      context, collection),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: removeFact,
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}

