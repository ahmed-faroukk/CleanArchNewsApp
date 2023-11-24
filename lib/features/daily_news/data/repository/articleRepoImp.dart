import 'dart:convert';
import 'dart:io';

import 'package:news_app/core/Constansts/Constants.dart';
import 'package:news_app/core/resources/data_state.dart';
import 'package:news_app/features/daily_news/data/data_sources/remote/api_service.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';
import 'package:news_app/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';


class ArticleRepositoryImpl implements ArticleRepository {

  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);


  @override
  Future<Resource<List<ArticleEntity>>> getNewsArticles() async {
    final response = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,

    );

    try {
      if (response.response.statusCode == HttpStatus.ok) {
        // Successful response
        print('Server Response:');
        print(response.response);
        return Success(response.data);
      } else {
        print('Server Response:');
        print(response.response);
        return Error(DioError(error: response.response.statusMessage,
            response: response.response,
            type: DioErrorType.response,
            requestOptions: response.response.requestOptions));
      }
    } on DioError catch (e) {
      return Error(e);
    }
  }

}