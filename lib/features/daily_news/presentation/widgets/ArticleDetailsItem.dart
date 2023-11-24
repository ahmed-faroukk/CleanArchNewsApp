import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/article.dart';

class ArticleDetailWidget extends StatelessWidget {
  final ArticleEntity article;

  const ArticleDetailWidget({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildArticleHeaderStack(context),
              _buildArticleDescription()
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
              child: buildImage(context)),
        ),
        // Title
        Positioned(
          bottom: 0,
          child: Flexible(
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Container(
                    alignment: Alignment.bottomLeft,
                    child: _buildArticleTitle()),
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
        '${article.title ?? ''}\n\n${article.description ?? ''}\n\n${article.content ?? ''}',
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
}
