import 'dart:convert';
import 'package:biblereels/collections/api/collection_api_implementation.dart';
import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CollectionApi implements CollectionApiImplementation {


  late final SharedPreferences prefs;

  @override
  Future initalize() async {
    prefs = await SharedPreferences.getInstance();
    return true;
  }

  Map<String, dynamic> getCollectionMap(String collectionId) {
    return json.decode(
      prefs.getString(collectionId)!);
  }


  @override
  List<Collection> getAllCollections() {
    List<Collection> collections = [];
    for (String collectionId in prefs.getKeys()) {
      collections.add(getCollection(collectionId));
    }
    return collections;
  }

  @override
  Collection getCollectionById(String collectionId) {
    return getCollection(collectionId);
  }

  @override
  Future<void> deleteCollection(String collectionId) async {
    await prefs.remove(collectionId);
  }

  @override
  Future<void> updateFacts(
    List<Fact> facts, 
    String collectionId
  ) async {
    Map<String, dynamic> collection = getCollectionMap(collectionId);
    collection['facts'] = {for (Fact fact in facts) fact.id: fact.toJson()};
    await  prefs.setString(collectionId, json.encode(collection));
  }

  @override
  Future<void> setCollection(Collection collection) async {
    await prefs.setString(
      collection.id, 
      collection.toJson()
    );
  }

  @override
  Collection getCollection(String  collectionId) {
    final collection = getCollectionMap(collectionId);
    return Collection.fromJson(collection, collectionId);
  }
}