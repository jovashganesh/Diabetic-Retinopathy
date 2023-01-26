import 'dart:convert';

import 'package:diabeticretinopathy/pages/newsmodel.dart';
import 'package:http/http.dart' as http;

// API code to make a request to the server to retrieve news articles
Future<List<NewsModel>> getNews() async {
  Uri uri = Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=health&apiKey=7f3dca4f47724527b0737614b76299a2"); //URL key to parse news atricles
  final response = await http.get(uri);
  if (response.statusCode == 200 || response.statusCode == 201) {
    Map<String, dynamic> map = json.decode(response.body);
    List _articalsList = map['articles']; //add all the retrieved articles to a new list
    List<NewsModel> newsList =
        _articalsList.map((jsonData) => NewsModel.fromJson(jsonData)).toList();
    print(_articalsList);
    return newsList;
  } else {
    print("error");
    return [];
  }
}
