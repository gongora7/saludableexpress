import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/models/news_details.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetails extends StatelessWidget {
  final NewsDetailsResponse newsDetailsResponse;

  const NewsDetails({
    Key key,
    this.newsDetailsResponse,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsDetailsResponse.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Hero(
              tag: newsDetailsResponse.newsId,
              child: CachedNetworkImage(
                imageUrl:
                    ApiProvider.imageBaseUrl + newsDetailsResponse.imagePath,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Html(data: newsDetailsResponse.description),
          ]),
        ),
      ),
    );
  }
}
