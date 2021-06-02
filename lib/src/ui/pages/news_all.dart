import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/news_response.dart';
import 'package:flutter_app1/src/blocs/news/news_bloc.dart';
import 'package:flutter_app1/src/repositories/news_repo.dart';
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
      padding: EdgeInsets.all(8.0),
      shrinkWrap: true,
      itemCount: data.newsData.length,
      itemBuilder: (context, index) {
        return ListTile(
            leading: Container(
              width: 100,
              height: 90,
              child: CachedNetworkImage(
                imageUrl: ApiProvider.imageBaseUrl +
                    data.newsData[index].newsImage,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress)),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(data.newsData[index].newsName, overflow: TextOverflow.ellipsis,),
            subtitle: Html(data: data.newsData[index].newsDescription.substring(0, 60)+" ..."),
        );
      }, separatorBuilder: (BuildContext context, int index) { return SizedBox(
      height: 8,
    );  },
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
