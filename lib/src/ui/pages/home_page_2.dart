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

// ignore: must_be_immutable
class HomePage2 extends StatefulWidget {
  bool isHeaderVisible = false;
  final Function(Product product) _toProductDetailPage;

  HomePage2(this.isHeaderVisible, this._toProductDetailPage);

  @override
  _HomePage2State createState() =>
      _HomePage2State(isHeaderVisible, _toProductDetailPage);
}

class _HomePage2State extends State<HomePage2> {
  bool isHeaderVisible = false;
  final _bannersBloc = BannersBloc(RealBannersRepo());
  bool fixedScroll = false;
  final Function(Product product) _toProductDetailPage;

  _HomePage2State(this.isHeaderVisible, this._toProductDetailPage);

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
          title: Text("HomePage 2"),
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
        ];
      },
      body: ProductsByCategories(
          0, "Newest", false, false, true, _toProductDetailPage),
    );
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
      itemBuilder: (BuildContext context, int itemIndex, _) {
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
