import 'package:biblereels/facts/fact.dart';
import 'package:biblereels/mock_facts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FactsApi {
  late final SharedPreferences prefs;

  Future initalize() async {
    prefs = await SharedPreferences.getInstance();
    return MockFacts.facts;
  }

  Future<List<Fact>> getAllFacts() async {
    return MockFacts.facts;
  }

}