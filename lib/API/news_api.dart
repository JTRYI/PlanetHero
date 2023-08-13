// make http request service
// this class allows us to make a simple get http request
//from the api and get the articles and then return a list of articles

import 'dart:convert';

import 'package:http/http.dart';

import '../models/article.dart';

class NewsApiService {
  // add enpoint url, check NewsAPI website documentation

  final endPointUrl =
      "https://newsapi.org/v2/everything?qInTitle=sustainability&from=2023-07-13&sortBy=publishedAt&apiKey=a9fb73f443d443c4ae0dbca77bb19298";

  //create http request function
  Future<List<Article>> getArticle() async {
    Response res = await get(Uri.parse(endPointUrl));

    //check if we got a 200 status code: means that request was a success
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      //this line will allow us to get the different articles from the json file and put them into a list
      List<Article> articles =
          body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't fetch articles");
    }
  }
}
