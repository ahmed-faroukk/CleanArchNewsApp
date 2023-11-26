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
      create: (_) => s1<LocalArticleBloc>()..add(const GetSavedArticlesEvent()),
      child: Scaffold(
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<LocalArticleBloc, LocalArticleState>(
      builder: (context, state) {
        if (state is LocalArticleLoading) {
          return Scaffold(
            body: const Center(child: CupertinoActivityIndicator()),
            backgroundColor: Theme.of(context).primaryColor,
          );
        } else if (state is LocalArticleDone) {
          return Scaffold(
            body: _buildArticlesList(context, state.article),
            backgroundColor: Theme.of(context).primaryColor,
          );
        }
        return Container();
      },
    );
  }

  Widget _buildArticlesList(
      BuildContext context, List<ArticleEntity>? articles) {
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
          child:  Hero(
            tag: article.url,
            transitionOnUserGestures: true,

            // Unique tag for each ArticleWidget
            child: ArticleWidget(
              article: article,
              onArticlePressed: (article) =>
                  _onArticlePressed(context, article),
            ),
          ),
        );
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }
}
