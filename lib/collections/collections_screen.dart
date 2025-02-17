import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/collections/models/collection_screen_model.dart';
import 'package:biblereels/collections/widgets/collection_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CollectionsScreen extends StatefulWidget {
  const CollectionsScreen({super.key});

  @override
  State<CollectionsScreen> createState() => _CollectionsScreenState();
}

class _CollectionsScreenState extends State<CollectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CollectionScreenModel>(
      create: (context) =>CollectionScreenModel.init(context.read()),
      child: Consumer<CollectionScreenModel>(
        builder: (context, collectionsModel, child) {
          List<Collection> collections = collectionsModel.collections;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Collections')        
            ),
            body: collections.isEmpty ? const Center(
              child: Text('No Collections')) : ListView(
              children: collections.map((collection) => 
              CollectionTile(collection: collection)).toList() 
            )
          );
        }
      ),
    );
  }
}