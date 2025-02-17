import 'package:biblereels/collections/models/collection.dart';
import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/facts/facts_repo.dart';
import 'package:uuid/uuid.dart';


class UpdateCollectionModel {
  Fact fact;
  FactsRepo factRepo;
  late List<Collection> collections;
  late Map<String, List<Fact>> updateMap;

  UpdateCollectionModel (
    this.fact,
    this.factRepo,
  ) {
    collections = factRepo.getAllCollections();
    updateMap = {};
    for (Collection collection in collections) {
      updateMap[collection.id] = collection.getFacts();
    }
  }


  void update(bool value , Collection collection) {
    List<Fact> facts = [...collection.getFacts()];
    value ? facts.add(fact) : facts.remove(fact);
    updateMap[collection.id] = facts;
  }

  bool hasFact(Collection collection) {
   return updateMap[collection.id]!.contains(fact); 
  }
  
  Map<String, List<Fact>> get updatedCollections {
    Map<String, List<Fact>> updated = {};
    for (Collection collection in collections) {
      if (collection.getFacts() != updateMap[collection.id]) {
        updated[collection.id] = updateMap[collection.id]!;
      }
    }
    return updated;
  }

  Future<void> save(String newCollectionName) async {
    for (Collection collection in collections) {
      if (collection.getFacts() != updateMap[collection.id]) {
        await factRepo.updateFacts(
          collection.id, updateMap[collection.id]!
        );
      }
    }
    if (newCollectionName.isNotEmpty) {
      await factRepo.setCollection(
        Collection(
          collectionName: newCollectionName,
          facts: {fact.id: fact}, 
          id: Uuid().v4()
        )
      );
    }
  }

}