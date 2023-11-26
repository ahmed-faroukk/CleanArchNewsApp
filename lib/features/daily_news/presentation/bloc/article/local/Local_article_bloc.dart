import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/domain/usecase/DeleteArticleUseCase.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/Local_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/Local_article_state.dart';
import '../../../../domain/usecase/GetSavedArticleUseCase.dart';
import '../../../../domain/usecase/SaveArticleUseCase.dart';

class LocalArticleBloc extends Bloc<LocalArticleEvents, LocalArticleState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final DeleteArticleUseCase _deleteArticleUseCase;

  LocalArticleBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._deleteArticleUseCase)
      : super(const LocalArticleLoading()) {
    on<GetSavedArticlesEvent>(onGetSavedArticles);
    on<DeleteArticleEvent>(onRemoveArticle);
    on<SaveArticleEvent>(onSaveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticlesEvent event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticleUseCase.invoke();
    emit(LocalArticleDone(articles));
    print(LocalArticleDone(articles));
  }

  void onRemoveArticle(
      DeleteArticleEvent removeArticle, Emitter<LocalArticleState> emit) async {
    await _deleteArticleUseCase.invoke(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase.invoke();
    emit(LocalArticleDone(articles));
  }

  void onSaveArticle(
      SaveArticleEvent saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase.invoke(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase.invoke();
    emit(LocalArticleDone(articles));
  }
}
