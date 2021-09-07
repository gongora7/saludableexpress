import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/news_response.dart';
import 'package:flutter_app1/src/blocs/news/news_bloc.dart';
import 'package:flutter_app1/src/models/news_details.dart';
import 'package:flutter_app1/src/repositories/news_repo.dart';
import 'package:flutter_app1/src/ui/pages/news_details.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsAll extends StatefulWidget {
  bool isHeaderVisible = false;

  NewsAll(this.isHeaderVisible);

  @override
  _NewsAllState createState() => _NewsAllState();
}

class _NewsAllState extends State<NewsAll>
    with AutomaticKeepAliveClientMixin<NewsAll> {
  final NewsBloc _newsBloc = NewsBloc(RealNewsRepo());

  @override
  void initState() {
    super.initState();

    _newsBloc.newsEventSink.add(GetNews(0, 0, null));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isHeaderVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text("News"),
        ),
        body: buildUi(context),
      );
    } else {
      return buildUi(context);
    }
  }

  Widget buildUi(BuildContext context) {
    return StreamBuilder(
        stream: _newsBloc.newsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return buildList(context, snapshot.data as NewsResponse);
            } else {
              return buildLoading();
            }
          } else {
            return buildLoading();
          }
        });
  }

  Widget buildList(BuildContext context, NewsResponse data) {
    return ListView.separated(
      padding: EdgeInsets.all(10.0),
      shrinkWrap: true,
      itemCount: data.newsData.length,
      itemBuilder: (context, index) {
        return Container(
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            onTap: () async {
              ApiProvider _apiProvider = ApiProvider();
              final NewsDetailsResponse newsDetailsResponse = await _apiProvider
                  .getNewsDetails(data.newsData[index].newsId);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetails(
                      newsDetailsResponse: newsDetailsResponse,
                    ),
                  ));
            },
            leading: Container(
              width: 130,
              child: Hero(
                tag: data.newsData[index].newsId,
                child: CachedNetworkImage(
                  width: 130.0,
                  imageUrl:
                      ApiProvider.imageBaseUrl + data.newsData[index].newsImage,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            title: Text(
              data.newsData[index].newsName,
              overflow: TextOverflow.fade,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Leer más'),
            /* subtitle: Html(
                data: data.newsData[index].newsDescription.substring(0, 60) +
                    " ..."),*/
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 12,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
