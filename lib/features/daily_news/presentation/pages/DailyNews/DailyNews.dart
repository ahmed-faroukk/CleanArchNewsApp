import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news_app/features/daily_news/presentation/pages/Settings/SettingsSceeen.dart';
import 'package:news_app/features/daily_news/presentation/pages/savedNews/SavedNews.dart';

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
  int _currentIndex = 0;
  // Define your pages here
  final List<Widget> _pages = [
    const DailyNews(),
    const SavedNews(),
    const SettingScreen(),
  ];
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
      backgroundColor: const Color(0xFFFFA559),
      bottomNavigationBar: _bottomNavBar(),
      body: Container(
        color: const Color(0xFFFFA559),
        child: _currentIndex == 0 ? _buildBody() : _pages[_currentIndex],      ),
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
        SliverAppBar(
          pinned: true,
          elevation: 10,
          expandedHeight: 150.0,
          backgroundColor: Theme.of(context).primaryColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Breaking News",
                style: Theme.of(context).textTheme.bodyLarge,
            ),
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
                        transitionOnUserGestures: true,

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

  _bottomNavBar() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: _isVisible ? kBottomNavigationBarHeight : 0.0,
          child: GNav(
            backgroundColor: Theme.of(context).primaryColor,
            activeColor: Colors.black,
            tabBackgroundColor: const Color(0x99FFA559),
            tabBorderRadius: 20,
            curve: Curves.fastOutSlowIn,
            // tab animation curves
            haptic: true,
            // haptic feedback
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
                text: "Settings ",
              ),
            ],
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ));
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
  }

  void _onSettingsPressed(BuildContext context) {
    Navigator.pushNamed(context, '/Settings');
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
