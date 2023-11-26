import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/presentation/pages/ArticleDetails/ArticleDetails.dart';
import 'package:news_app/features/daily_news/presentation/pages/Settings/SettingsSceeen.dart';
import 'package:news_app/features/daily_news/presentation/pages/savedNews/SavedNews.dart';

import '../../../features/daily_news/domain/entities/article.dart';
import '../../../features/daily_news/presentation/pages/DailyNews/DailyNews.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetails(article: settings.arguments as ArticleEntity ));

      case '/SavedArticles':
        return _materialRoute( const SavedNews());

      case '/Settings':
        return _materialRoute( const SettingScreen());

      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
