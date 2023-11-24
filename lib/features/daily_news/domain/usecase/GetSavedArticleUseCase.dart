import 'package:news_app/core/usecase/GenaricUsecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository articleRepository;
  GetSavedArticleUseCase(this.articleRepository);

  @override
  Future<List<ArticleEntity>> invoke({void params}) {
    return articleRepository.getSavedArticle();
  }


}
