import 'dart:convert';
import 'package:biblereels/facts/fact.dart';
import 'package:equatable/equatable.dart';

class Collection with EquatableMixin {
  final String id;
  final String collectionName;
  final Map<String, Fact> facts;
  Collection({
    required this.id,
    required this.collectionName, 
    required this.facts});


  Collection copyWith({
    String? collectionName,
    Map<String, Fact>? facts,
  }) {
    return Collection(
      id: id,
      collectionName: collectionName ?? this.collectionName,
      facts: facts ?? this.facts,
    );
  }

  String toJson() {
    return json.encode({
      'collectionName': collectionName,
      'facts': facts.map((key, value) => MapEntry(key, value.toJson()))
    });
  }



  factory Collection.fromJson(Map<String, dynamic> json, String id) {
    return Collection(
      id: id,
      collectionName: json['collectionName'],
      facts: json['facts'].map(
          (key, value) => MapEntry(key, Fact.fromJson(value)),
        ).cast<String, Fact>()
    );
  }

  bool contains(Fact fact) =>facts.containsKey(fact.id);
  List<Fact> getFacts() => facts.values.toList();
  
  @override
  List<Object?> get props => [id];

}