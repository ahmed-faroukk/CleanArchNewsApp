import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:news_app/features/daily_news/presentation/widgets/LoveBtn.dart';

import '../../../../injection_container.dart';
import '../../domain/entities/article.dart';
import '../bloc/article/local/Local_article_bloc.dart';
import '../bloc/article/local/Local_article_event.dart';

class ArticleDetailWidget extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailWidget({super.key,  required this.article});

  @override
  State createState() => _ArticleDetailWidget(article: article);
}

class _ArticleDetailWidget extends State<ArticleDetailWidget> {
  final ArticleEntity article;

   _ArticleDetailWidget({
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    bool isLoved  = false ;
    return _buildBody(context);
  }

 Widget _buildBody(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildArticleHeaderStack(context),
              _buildArticleDescription(),
              LoveButton(onClick:() {
                _onLoveButtonPressed(context , article , "");
              })
            ],
          ),
        ),
      ),
    );
  }




  Widget buildArticleHeaderStack(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Image
        Container(
          width: double.infinity, // Fill width
          height: 400,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: buildImage(context),
          ),
        ),
        // Title
        Positioned(
          bottom: 0,
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width, // Use the screen width
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black, Colors.transparent],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 20), // Adjust the padding as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildArticleTitle(),
                  // You can add other widgets here like the article subtitle or date
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Text(
        '${article.title}\n\n${article.description}\n\n${article.content}',
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildArticleTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          article.title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text for contrast
          ),
        ),
        Text(
          "At : " + article.publishedAt,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // White text for contrast
          ),
        ),
      ],
    );
  }

  Widget buildImage(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: article.urlToImage,
        imageBuilder: (context, imageProvider) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: const CupertinoActivityIndicator(),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            ),
        errorWidget: (context, url, error) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: Icon(Icons.image),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                  ),
                ),
              ),
            ));
  }

   _onLoveButtonPressed(BuildContext context , ArticleEntity article , String sankMsg) {
    BlocProvider.of<LocalArticleBloc>(context).add(SaveArticleEvent(article));
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        backgroundColor: Colors.black,
        content: Text('Article saved successfully \n $sankMsg'),
        duration: const Duration(seconds: 2),
      ),
    );

  }
  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
  }


}
