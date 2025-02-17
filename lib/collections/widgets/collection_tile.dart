import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/collections/widgets/collection_reel.dart';
import 'package:biblereels/collections/models/collection_screen_model.dart';
import 'package:biblereels/collections/models/collection_view_model.dart';
import 'package:biblereels/widgets/custom_text.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollectionTile extends StatelessWidget {
  final Collection collection;
  const CollectionTile({
    super.key, required this.collection});


  @override
  Widget build(BuildContext context) {
    
    void onDelete() => 
      context.read<CollectionScreenModel>().deleteCollection(collection);

    return ChangeNotifierProvider<CollectionViewModel>(
      create: (context) => CollectionViewModel(
        context.read<FactsRepo>(), collection),
      child: Consumer<CollectionViewModel>(
        builder: (context, collectionModel, child) {
          int count = collectionModel.facts.length;
          return InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider.value(
                value: collectionModel,
                child: CollectionReel(
                  onDelete: onDelete
                )),
            )),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 15
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(collectionModel.collectionName,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  CustomText(
                    '$count ${count == 1 ? 'story' : 'stories'}',
                    fontSize: 15,
                    color: const Color.fromARGB(151, 255, 255, 255)
                  ),
                ],
              ),
            ),
          ); 
        }
      )
    );
  }
}