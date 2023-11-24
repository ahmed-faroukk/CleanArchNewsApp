import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/data/data_sources/local/dao/ArticleDao.dart';
import 'package:news_app/features/daily_news/data/models/Article.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'AppDataBase.g.dart' ;

@Database(version: 1, entities: [ArticleModel])
abstract class AppDataBase extends FloorDatabase {

  ArticleDao get articleDao ;

}