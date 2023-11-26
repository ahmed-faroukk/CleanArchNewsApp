import 'package:news_app/core/usecase/GenaricUsecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class SaveArticleUseCase implements UseCase<void , ArticleEntity> {
  final ArticleRepository articleRepository;
  SaveArticleUseCase(this.articleRepository);

  @override
  Future<void> invoke({ArticleEntity? params}) {
    return articleRepository.saveArticle(params!);
  }


}
