import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:flutter/material.dart';

class CollectionViewModel extends ChangeNotifier {
  final Collection _collection;
  String collectionName;
  String id;
  FactsRepo factsRepo;
  Map<String, Fact> facts;

  CollectionViewModel(
    this.factsRepo,
    this._collection
  ) : 
    id = _collection.id,
    collectionName = _collection.collectionName,
    facts = _collection.facts; 

  bool contains(Fact fact) => facts.keys.contains(fact.title);
  List<Fact> getFacts() => facts.values.toList();

  Collection toCollection() => _collection.copyWith(
    collectionName: collectionName,
    facts: facts
  );

  Future<void> removeFact(Fact fact) async {
    facts.remove(fact.id);
    notifyListeners();
    await factsRepo.updateFacts(id, getFacts());
  }

  Future<void> changeName(String newName) async {
    collectionName = newName;
    await factsRepo.setCollection(toCollection());
    notifyListeners();
  }

}