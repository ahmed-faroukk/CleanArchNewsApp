import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/Local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/Local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/Local_article_state.dart';
import 'package:news_app/features/daily_news/presentation/widgets/article_tile.dart';

import '../../../../../injection_container.dart';


class SavedNews extends StatefulWidget {
  const SavedNews({super.key});

  @override
  State<SavedNews> createState() {
    return SavedNewsState();
  }

}

class SavedNewsState extends State<SavedNews> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      s1<LocalArticleBloc>()
        ..add(const GetSavedArticlesEvent()),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }


  Widget _buildBody(BuildContext context) {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        } else if (state is LocalArticleDone) {
          return _buildArticlesList(context, state.article);
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(BuildContext context,
      List<ArticleEntity>? articles) {
    if (articles == null || articles.isEmpty) {
      return const Center(
        child: Text(
          'NO SAVED ARTICLES',
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];

        return Dismissible(
          key: Key(article.id.toString()),
          // Use a unique key for each article
          background: Container(
            color: Colors.red, // Background color when swiping
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Delete the article when swiped
            BlocProvider.of<LocalArticleBloc>(context)
                .add(DeleteArticleEvent(article));
          },
          child: ArticleWidget(article: article),
        );
      },
    );
  }
}

