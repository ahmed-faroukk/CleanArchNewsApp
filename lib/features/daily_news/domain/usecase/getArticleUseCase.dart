import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/core/usecase/usecase.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase implements UseCase<Resource<List<ArticleEntity>>, void> {
  final ArticleRepository articleRepository;

  GetArticleUseCase(this.articleRepository);

  @override
  Future<Resource<List<ArticleEntity>>> invoke({void params}) {
    return articleRepository.getNewsArticles();
  }

}
