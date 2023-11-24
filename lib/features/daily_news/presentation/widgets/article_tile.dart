import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity article;

  final bool? isRemovable;

  final void Function(ArticleEntity article)? onRemove;

  final void Function(ArticleEntity article)? onArticlePressed;

  const ArticleWidget({
    Key? key,
    required this.article,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTab ,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(12.0), // Adjust the radius as needed
            ),
            padding: const EdgeInsetsDirectional.only(
                start: 20, end: 20, bottom: 25, top: 25),
            height: MediaQuery.of(context).size.width / 1.9,
            child: Scaffold(
              body: Row(
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      buildImage(context),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              article.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Flexible(
                            child: Text(
                              "Time : " + article.publishedAt,
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ],
                      ))
                    ],
                  ))
                ],
              ),
            ),
          ),
      ),
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

  onTab() {
    if (onArticlePressed != null) {
      onArticlePressed!(article);
    }
  }
}
