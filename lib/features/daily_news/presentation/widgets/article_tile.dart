import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget{
  final ArticleEntity ? article ;
  final bool ? isRemovable ;
  final void Function(ArticleEntity article) ? onRemove ;
  final void Function(ArticleEntity article) ? onArticlePressed ;

  const ArticleWidget({
    Key ? key,
    this.article,
    this.onArticlePressed,
    this.isRemovable = false,
    this.onRemove,
  }): super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap:  () {},
  
        child: Container(
          padding: const EdgeInsetsDirectional.only(start: 14 , end: 14 , bottom: 7 , top: 7),
          height: MediaQuery.of(context).size.width /  2.2 ,
          child:  Row(
            children: [
              buildImage(context),
            ],
          ),
        ),
    );
  }

  Widget buildImage(BuildContext context){
    return CachedNetworkImage(imageUrl: article!.urlToImage! ,
      imageBuilder : (context, imageProvider) => Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover
                ),
            ),
          ),
        ),
      ) ,

        progressIndicatorBuilder : (context, url, downloadProgress) => Padding(
          padding: const EdgeInsetsDirectional.only(end: 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              child: const CupertinoActivityIndicator(),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
              ),
            ),
          ),
        ),

        errorWidget : (context, url, error) =>
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 14),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: double.maxFinite,
                  child: Icon(Icons.error),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                  ),
                ),
              ),
            )
    );

  }
  onTab(){
    if(onArticlePressed != null){
      onArticlePressed!(article!);
    }
  }


}