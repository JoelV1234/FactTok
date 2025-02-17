import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CollectionCheck extends StatefulWidget {
  final bool isSelected;
  final Function(bool value, Collection collection) onTap;
  final Collection collection;
  const CollectionCheck({
    super.key, 
    required this.collection, 
    required this.isSelected, 
    required this.onTap
  });

  @override
  State<CollectionCheck> createState() => _CollectionCheckState();
}

class _CollectionCheckState extends State<CollectionCheck> {

  @override
  Widget build(BuildContext context) {
    String collectionName = widget.collection.collectionName;
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          CustomText(
            collectionName,
            color: Colors.black,
          ),
          Expanded(child: Container()),
          Checkbox(
            value: widget.isSelected,
            onChanged: (value) => widget.onTap(value!, widget.collection),
          ),
        ],
      ),
    );
  }
}