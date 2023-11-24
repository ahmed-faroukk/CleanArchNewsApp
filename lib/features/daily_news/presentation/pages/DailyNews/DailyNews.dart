import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../domain/entities/article.dart';
import '../../widgets/article_tile.dart';

class DailyNews extends StatefulWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  State<DailyNews> createState() {
    return _DailyNews();
  }
}

class _DailyNews extends State<DailyNews> {
  bool _isVisible = true;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF542BBA),
      bottomNavigationBar: _bottomNavBar(),
      body: Container(
        color: const Color(0xFF542BBA),
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticleBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticleLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }
        if (state is RemoteArticleError) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticleDone) {
          return newsList(state);
        }

        return const SizedBox();
      },
    );
  }

  newsList(RemoteArticleState state) {

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverAppBar(
          pinned: true,
          elevation: 10,
          expandedHeight: 150.0,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Breaking News",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Material(
                      child: Hero(
                        tag: state.article![index].url,
                        transitionOnUserGestures: true ,

                        // Unique tag for each ArticleWidget
                        child: ArticleWidget(
                          article: state.article![index],
                          onArticlePressed: (article) =>
                              _onArticlePressed(context, article),
                        ),

                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: state.article!.length,
          ),
        ),
      ],
    );
  }
  _bottomNavBar(){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: _isVisible ? kBottomNavigationBarHeight : 0.0,
          child: GNav(
            backgroundColor: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: const Color(0XFF876bcf),
            tabBorderRadius: 20,
            curve: Curves.fastOutSlowIn,
            // tab animation curves
            haptic: true,
            // haptic feedback
            tabShadow: [
              BoxShadow(color: Colors.white.withOpacity(0.2), blurRadius: 8)
            ],
            // tab button shadow
            gap: 15,
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Feeds",
              ),
              GButton(
                icon: Icons.favorite,
                text: "Saved",
              ),
              GButton(
                icon: Icons.web,
                text: "Detail ",
              ),
            ],
            onTabChange: (index) {
              if (index == 1) {
                _onShowSavedArticlesViewTapped(context);
              }
            },
          ),
        ));
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
