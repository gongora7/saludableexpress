import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';
import 'package:flutter_app1/src/api/responses/news_response.dart';
import 'package:flutter_app1/src/blocs/banners/banners_bloc.dart';
import 'package:flutter_app1/src/blocs/news/news_bloc.dart';
import 'package:flutter_app1/src/repositories/banners_repo.dart';
import 'package:flutter_app1/src/repositories/news_repo.dart';
import 'package:flutter_app1/src/ui/pages/news_all.dart';

class News extends StatefulWidget {
  bool isHeaderVisible = false;

  News(this.isHeaderVisible);

  @override
  _NewsState createState() => _NewsState(isHeaderVisible);
}

class _NewsState extends State<News> with TickerProviderStateMixin {
  bool isHeaderVisible = false;

  _NewsState(this.isHeaderVisible);

  final NewsBloc _newsBloc = NewsBloc(RealNewsRepo());

  @override
  void initState() {
    super.initState();

    _newsBloc.newsEventSink.add(GetNews(0, 1, null));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isHeaderVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text("News"),
        ),
        body: buildSingleChildScrollView(context),
      );
    } else {
      return buildSingleChildScrollView(context);
    }
  }

  Widget buildSingleChildScrollView(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverToBoxAdapter(
            child: StreamBuilder(
                stream: _newsBloc.newsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return buildColumnWithData(
                          context, snapshot.data as NewsResponse);
                    } else {
                      return buildLoading();
                    }
                  } else {
                    return buildLoading();
                  }
                }),
          )
        ];
      },
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(tabs: [
              Tab(
                text: "All",
              ),
              Tab(
                text: "News Category",
              ),
            ]),
            Expanded(
              child: Container(
                child: TabBarView(children: [
                  NewsAll(false),
                  Center(child: Text("News Category")),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildColumnWithData(BuildContext context, NewsResponse newsResponse) {
  return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: newsResponse.newsData.length > 1 ? false : false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {},
        scrollDirection: Axis.horizontal,
      ),
      itemCount: newsResponse.newsData.length,
      itemBuilder: (BuildContext context, int itemIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            imageUrl: ApiProvider.imageBaseUrl +
                newsResponse.newsData[itemIndex].newsImage,
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress)),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        );
      });
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
