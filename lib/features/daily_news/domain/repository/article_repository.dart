import 'package:news_app/features/daily_news/domain/entities/article.dart';

import '../../../../core/resources/data_state.dart';

abstract class ArticleRepository {
  // api call with
  Future<Resource<List<ArticleEntity>>> getNewsArticles();

  // database methods
  Future<List<ArticleEntity>> getSavedArticle();

  Future <void> saveArticle(ArticleEntity article);

  Future <void> removeArticle(ArticleEntity article);

}
