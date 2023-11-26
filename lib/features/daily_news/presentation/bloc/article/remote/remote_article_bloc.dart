import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../../../domain/usecase/getArticleUseCase.dart';

class RemoteArticleBloc extends Bloc<RemoteArticleEvents , RemoteArticleState>{

  final GetArticleUseCase getArticleUseCase ;
  
  RemoteArticleBloc(this.getArticleUseCase) : super(const RemoteArticleLoading()) {
    on <GetArticles> (onGetArticle) ;
  }

  void onGetArticle(GetArticles event , Emitter<RemoteArticleState> emit) async {
    final dataState = await getArticleUseCase.invoke() ;
    print("loading");

    if(dataState is Success && dataState.data!.isNotEmpty ){
      print(dataState.data);
      emit(
        RemoteArticleDone(dataState.data!)
      );
    }
    
    if(dataState is Error){
      print(dataState.error!.message);
      emit(
        RemoteArticleError(dataState.error!)
      );
    }
  }


}