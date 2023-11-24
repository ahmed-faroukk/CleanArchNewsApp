
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/AppDataBase.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/api_service.dart';
import 'package:dio/dio.dart';
import 'package:news_app/features/daily_news/data/repository/articleRepoImp.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_app/features/daily_news/domain/usecase/DeleteArticleUseCase.dart';
import 'package:news_app/features/daily_news/domain/usecase/GetSavedArticleUseCase.dart';
import 'package:news_app/features/daily_news/domain/usecase/SaveArticleUseCase.dart';
import 'package:news_app/features/daily_news/domain/usecase/getArticleUseCase.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/local/Local_article_bloc.dart';
import 'package:news_app/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';

import 'config/controller/NetworkController.dart';

final s1 = GetIt.instance ;

Future<void> initializeDependencies() async {

  // database
  final database = await $FloorAppDataBase.databaseBuilder('app_database.db').build();
  s1.registerSingleton<AppDataBase>(database);

  // dio
  s1.registerSingleton(Dio());
  s1.registerSingleton(NewsApiService(s1()));

  // inject api services into repo
  s1.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(s1() , s1()));

  // inject repo into  use cases
  s1.registerSingleton(GetArticleUseCase(s1()));
  s1.registerSingleton(SaveArticleUseCase(s1()));
  s1.registerSingleton(DeleteArticleUseCase(s1()));
  s1.registerSingleton(GetSavedArticleUseCase(s1()));

  // inject use case into bloc
  s1.registerFactory<RemoteArticleBloc>(
          ()=> RemoteArticleBloc(s1())
  );

  // inject use case into bloc
  s1.registerFactory<LocalArticleBloc>(
          ()=> LocalArticleBloc(s1() ,s1(), s1())
  );





}

class ControllerInit  {

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }

}
