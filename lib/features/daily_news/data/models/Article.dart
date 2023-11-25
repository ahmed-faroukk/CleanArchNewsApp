import 'package:floor/floor.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

import '../../../../core/Constansts/Constants.dart';

@Entity(tableName: 'article' , primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  const ArticleModel({
     this.id,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) : super(

            id: id,
            author: author,
            title: title,
            description: description,
            url: url,
            urlToImage: urlToImage,
            publishedAt: publishedAt,
            content: content);

  // to convert json file to dart object
  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      author: map['author'] ?? "",
      title: map['title'] ?? "",
      description: map['description'] ?? "",
      url: map['url'] ?? "", urlToImage: map['urlToImage'] != null && map['urlToImage'] != "" ? map['urlToImage'] : kDefaultImage,
        publishedAt: map['publishedAt'] ?? "",
      content: map['content'] ?? ""
    );
  }
  factory ArticleModel.fromEntity(ArticleEntity entity) {
    return ArticleModel(
        id: entity.id,
        author: entity.author,
        title: entity.title,
        description: entity.description,
        url: entity.url,
        urlToImage: entity.urlToImage,
        publishedAt: entity.publishedAt,
        content: entity.content
    );
  }
}
