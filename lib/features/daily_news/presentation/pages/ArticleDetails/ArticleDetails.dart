import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app/features/daily_news/presentation/widgets/ArticleDetailsItem.dart';
import 'package:news_app/injection_container.dart';

import '../../../domain/entities/article.dart';

class ArticleDetails extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetails({Key? key, this.article }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(tag: article!.url
          ,transitionOnUserGestures: true ,
        child: Center(child: ArticleDetailWidget(article: article!)),
      )
    );
  }
}