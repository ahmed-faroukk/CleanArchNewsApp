import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:news_app/features/daily_news/presentation/widgets/ArticleDetailsItem.dart';
import 'package:news_app/injection_container.dart';

import '../../../domain/entities/article.dart';
import '../../bloc/article/local/Local_article_bloc.dart';

class ArticleDetails extends HookWidget {
  final ArticleEntity? article;

  const ArticleDetails({Key? key, this.article }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => s1<LocalArticleBloc>(),
        child: _buildBody(article)
    );
  }
}

_buildBody(ArticleEntity ? article ){
  return  Scaffold(
      body: Hero(tag: article!.url
        ,transitionOnUserGestures: true ,
        child: Center(child: ArticleDetailWidget(article: article!)),
      )
  );
}
