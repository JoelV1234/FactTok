import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/facts/fact.dart';

abstract class CollectionApiImplementation {
  Future initalize();
  List<Collection> getAllCollections();
  Collection getCollectionById(String collectionId);
  Future<void> deleteCollection(String collectionId);
  Future<void> updateFacts(List<Fact> facts, String collectionId);
  Future<void> setCollection(Collection collection);
  Collection getCollection(String  collectionId);
} 