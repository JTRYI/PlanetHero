
import 'package:flutter/material.dart';
import 'package:planethero_application/API/news_api.dart';
import 'package:planethero_application/widgets/news-article.dart';

import '../models/article.dart';

class NewsScreen extends StatefulWidget {
  //declare route name
  static String routeName = '/news';

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsApiService newsAPI = NewsApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sustainability News',
            style: TextStyle(fontFamily: 'Roboto Bold'),
          ),
        ),
        //call news api service with futurebuilder widget
        body: FutureBuilder(
            future: newsAPI.getArticle(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
              if (snapshot.hasData) {
                //make a list of articles
                List<Article>? articles = snapshot.data;
                return ListView.builder(
                  itemCount: articles!.length,
                  itemBuilder: (context, index) =>
                      customArticleListTile(articles[index], context),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
