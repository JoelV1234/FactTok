import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:flutter/material.dart';

class CollectionScreenModel extends ChangeNotifier {
  FactsRepo factsRepo;
  List<Collection> collections;

  CollectionScreenModel({
    required this.factsRepo,
    required this.collections
  });

  factory CollectionScreenModel.init(
    FactsRepo factsRepo
  ) {
    List<Collection> collections = factsRepo.getAllCollections();
    return CollectionScreenModel(
      factsRepo: factsRepo,
      collections: collections
    );
  }

  Future<void> deleteCollection(Collection collection) async {
    await factsRepo.deleteCollection(collection.id);
    collections.remove(collection);
    notifyListeners();
  }

}