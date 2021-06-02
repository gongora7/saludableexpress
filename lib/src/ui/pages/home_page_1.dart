import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';
import 'package:flutter_app1/src/api/responses/products_response.dart';
import 'package:flutter_app1/src/blocs/banners/banners_bloc.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/blocs/products/products_bloc.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/product_models/product_post_model.dart';
import 'package:flutter_app1/src/repositories/banners_repo.dart';
import 'package:flutter_app1/src/repositories/categories_repo.dart';
import 'package:flutter_app1/src/ui/widgets/products_by_categories.dart';
import 'package:flutter_app1/src/ui/widgets/products_by_type.dart';
import 'package:flutter_app1/src/ui/widgets/products_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage1 extends StatefulWidget {
  bool isHeaderVisible = false;
  final Function(Product product) _toProductDetailPage;

  HomePage1(this.isHeaderVisible, this._toProductDetailPage);

  @override
  _HomePage1State createState() =>
      _HomePage1State(isHeaderVisible, _toProductDetailPage);
}

class _HomePage1State extends State<HomePage1> {
  bool isHeaderVisible = false;
  final _bannersBloc = BannersBloc(RealBannersRepo());
  bool fixedScroll = false;
  final Function(Product product) _toProductDetailPage;

  _HomePage1State(this.isHeaderVisible, this._toProductDetailPage);

  @override
  void initState() {
    super.initState();

    _bannersBloc.banners_event_sink.add(GetBanners());
  }

  @override
  void dispose() {
    super.dispose();
    _bannersBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isHeaderVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text("HomePage 1"),
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
                  stream: _bannersBloc.banners_stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data != null) {
                        return buildColumnWithData(
                            context, snapshot.data as BannersResponse);
                      } else {
                        return buildLoading();
                      }
                    } else {
                      return buildLoading();
                    }
                  })),
          SliverToBoxAdapter(
            child: ProductsByType(this._toProductDetailPage),
          ),
/*
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  padding: new EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Flash Sale",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 220,
                  child: Products("flashsale", "", true, false, false,
                      _toProductDetailPage),
                ),
              ],
            ),
          ),
*/
/*
          SliverToBoxAdapter(
            child: Container(
              height: 200,
              child: Center(
                child: Text("Recent  Products"),
              ),
            ),
          ),
*/
        ];
      },
      body: ProductsByCategories(0, "Newest", false, false, false, _toProductDetailPage),
    );

    /*Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ProductsByCategories(),
      ],
    );

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: StreamBuilder(
                stream: _bannersBloc.banners_stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return buildColumnWithData(
                          context, snapshot.data as BannersResponse);
                    } else {
                      return buildLoading();
                    }
                  } else {
                    return buildLoading();
                  }
                }),
          ),

*/ /*
          Flexible(
            child: Products("top seller"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Hello"),
          ),
          Flexible(
            child: Products(""),
          ),
*/ /*
*/ /*
          RaisedButton(
            onPressed: () {
              BlocProvider.of<LanguageBloc>(context)
                  .add(LanguageSelected(Language.AR));
            },
            child: Text("arabic"),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<LanguageBloc>(context)
                  .add(LanguageSelected(Language.EN));
            },
            child: Text("english"),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context)
                  .add(ThemeChanged(theme: AppTheme.GreenDark));
            },
            child: Text("Dark theme"),
          ),
          RaisedButton(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context)
                  .add(ThemeChanged(theme: AppTheme.GreenLight));
            },
            child: Text("Light theme"),
          ),
*/ /*
        ],
      ),
    );*/
  }
}

Widget buildColumnWithData(
    BuildContext context, BannersResponse bannersResponse) {
  return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll:
            bannersResponse.bannersData.length > 1 ? false : false,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 600),
        autoPlayCurve: Curves.linear,
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {},
        scrollDirection: Axis.horizontal,
      ),
      itemCount: bannersResponse.bannersData.length,
      itemBuilder: (BuildContext context, int itemIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          child: CachedNetworkImage(
            imageUrl: ApiProvider.imageBaseUrl +
                bannersResponse.bannersData[itemIndex].image,
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
