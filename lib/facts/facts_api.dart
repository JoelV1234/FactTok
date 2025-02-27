import 'package:biblereels/facts/fact.dart';
import 'package:dio/dio.dart';

class FactsApi {
  String baseUrl = "https://facttok-api.onrender.com";
  final dio = Dio();

  Future<List<Fact>> getAllFacts() async {
    final response = await dio.get('$baseUrl/facts');
    List<Fact> facts = response.data.map<Fact>((fact) {
      return Fact.fromJson(fact);
    }).toList();
    facts.shuffle();
    return facts;
  }

}