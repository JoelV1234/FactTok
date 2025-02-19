import 'package:biblereels/facts/fact.dart';
import 'package:flutter/material.dart';

class CollectionThumbnail extends StatelessWidget {
  final List<Fact> facts;
  const CollectionThumbnail({super.key, required this.facts});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(facts[0].photourl ?? ''),
              fit: BoxFit.cover
            )
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black54
          ),
        ),
      ],
    );
  }
}