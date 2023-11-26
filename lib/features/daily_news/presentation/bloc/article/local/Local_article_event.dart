import '../../../../domain/entities/article.dart';

abstract class LocalArticleEvents {
  final ArticleEntity ? article;

  const LocalArticleEvents({this.article});

  @override
  List<Object> get props => [article!];
}

class GetSavedArticlesEvent extends LocalArticleEvents{
  const GetSavedArticlesEvent();
}


class SaveArticleEvent extends LocalArticleEvents{
  const SaveArticleEvent(ArticleEntity article) : super(article: article);
}


class DeleteArticleEvent extends LocalArticleEvents{
  const DeleteArticleEvent(ArticleEntity article) : super(article: article);
}