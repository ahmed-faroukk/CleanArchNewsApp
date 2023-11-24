
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/data/repository/articleRepoImp.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/usecase/getArticleUseCase.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'config/controller/NetworkController.dart';

final s1 = GetIt.instance ;

Future<void> initializeDependencies() async {
  // dio
  s1.registerSingleton(Dio());
  s1.registerSingleton(NewsApiService(s1()));

  // inject api services into repo
  s1.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(s1()));

  // inject repo into  use case
  s1.registerSingleton(GetArticleUseCase(s1()));

  // inject use case into bloc
  s1.registerFactory<RemoteArticleBloc>(
          ()=> RemoteArticleBloc(s1())
  );




}

class ControllerInit  {

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }

}
