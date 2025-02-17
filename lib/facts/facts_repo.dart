import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/collections/api/collection_api.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/facts/facts_api.dart';
import 'package:flutter/material.dart';

class FactsRepo extends ChangeNotifier {

  final FactsApi factsApi;
  final CollectionApi collectionApi;
  FactsRepo({
    required this.factsApi, 
    required this.collectionApi});

  Future<List<Fact>> getAllReels() => 
    factsApi.getAllFacts();

  List<Collection> getAllCollections() => 
    collectionApi.getAllCollections();
  
  
  Future<void> setCollection(Collection collection) =>
    collectionApi.setCollection(collection);

  Future<void> deleteCollection(String collectionId) =>
    collectionApi.deleteCollection(collectionId);

  Future<void> updateFacts(
    String collectionId, 
    List<Fact> facts
  ) async{
    await (facts.isEmpty ? 
      collectionApi.deleteCollection(collectionId) :
      collectionApi.updateFacts(facts, collectionId));
  }

  List<Collection> inCollection(Fact fact) => 
    getAllCollections().where(
      (collection) => collection.contains(fact)).toList();
}