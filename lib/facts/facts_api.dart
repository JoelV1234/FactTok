import 'package:biblereels/facts/fact.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'package:uuid/uuid.dart';

class FactsApi {
  List<String> factsUrl = [
    'https://www.thefactsite.com/top-100-technology-facts/',
    'https://www.thefactsite.com/100-random-food-facts/'
  ];
  final dio = Dio();

String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(
      r"<[^>]*>",
      multiLine: true,
      caseSensitive: true
    );
    return htmlText.replaceAll(exp, '');
  }

  Future<List<Fact>> getAllFacts() async {
    List<Fact> facts = [];  
    for (var url in factsUrl) {
      final response = await dio.get(url);
      RegExp regExp = RegExp(r'<h2 class="list">(.*?)<h2 class="list">', dotAll: true);
      final getFactTags = regExp.allMatches(response.data).toList();
      for (var tags in getFactTags) {
        final parsed = parse('<h2 class="list">${tags.group(1).toString()}');
        String title = parsed.getElementsByTagName("h2")[0].innerHtml;
        final image = parsed.getElementsByTagName("img")[0].attributes['data-src'];
        final paragraphs = parsed.getElementsByTagName("p");
        String description = "";
        for (var i = 1; i < paragraphs.length; i++) {
          description += paragraphs[i].innerHtml;
        }
        facts.add(Fact(
          title: removeAllHtmlTags(title),
          description: removeAllHtmlTags(description),
          photourl: image,
        ));
      }
        
      
    }
    facts.shuffle();
    return facts;
  }

}