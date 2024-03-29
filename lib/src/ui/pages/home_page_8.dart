import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/banners_response.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/blocs/banners/banners_bloc.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/models/categories_response/category.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/repositories/banners_repo.dart';
import 'package:flutter_app1/src/ui/pages/shop.dart';
import 'package:flutter_app1/src/ui/widgets/products_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomePage8 extends StatefulWidget {
  bool isHeaderVisible = false;
  final Function(Product product) _toProductDetailPage;

  HomePage8(this.isHeaderVisible, this._toProductDetailPage);

  @override
  _HomePage8State createState() => _HomePage8State(isHeaderVisible);
}

class _HomePage8State extends State<HomePage8> {
  var isHeaderVisible;
  final _bannersBloc = BannersBloc(RealBannersRepo());

  _HomePage8State(this.isHeaderVisible);

  @override
  void initState() {
    super.initState();
    _bannersBloc.banners_event_sink.add(GetBanners());

    // ignore: close_sinks
    final categoryBloc = BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    if (isHeaderVisible) {
      return Scaffold(
        appBar: AppBar(
          title: Text("HomePage 8"),
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
            child: Column(
              children: [
                buildUI(),
                Container(
                  padding: new EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top Sellers",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 220,
                    child: Products("top seller", "", true, false, false,
                        widget._toProductDetailPage)),
                Container(
                  padding: new EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Most Liked",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 220,
                    child: Products("most liked", "", true, false, false,
                        widget._toProductDetailPage)),
                Container(
                  padding: new EdgeInsets.all(14.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "All Products",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      body: Products(
          "Newest", "", false, false, false, widget._toProductDetailPage),
    );
  }

  Widget buildUI() {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesInitial) {
          return buildLoading();
        } else if (state is CategoriesLoading) {
          return buildLoading();
        } else if (state is CategoriesLoaded) {
          return buildColumnWithData2(
              context, getParentCategories(state.categoriesResponse));
        } else if (state is CategoriesError) {
          return buildLoading();
        } else {
          return buildLoading();
        }
      },
    );
  }

  Widget buildColumnWithData2(BuildContext context, List<Category> categories) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Shop(categories[index].categoriesId,
                          "newest", true, widget._toProductDetailPage)));
            },
            child: Container(
              width: 120,
              margin: EdgeInsets.all(2.0),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: CachedNetworkImage(
                          imageUrl: ApiProvider.imageBaseUrl +
                              categories[index].image,
                          fit: BoxFit.fill,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Text(categories[index].categoriesName),
                  Text(
                      categories[index].totalProducts.toString() + " Products"),
                ],
              ),
            ),
          );
        },
      ),
    );
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

  List<Category> getParentCategories(CategoriesResponse categoriesResponse) {
    List<Category> categories = [];
    for (int i = 0; i < categoriesResponse.categoriesData.length; i++) {
      if (categoriesResponse.categoriesData[i].parentId == 0)
        categories.add(categoriesResponse.categoriesData[i]);
    }
    return categories;
  }
}

List<Category> getParentCategories(CategoriesResponse categoriesResponse) {
  List<Category> categories = [];
  for (int i = 0; i < categoriesResponse.categoriesData.length; i++) {
    if (categoriesResponse.categoriesData[i].parentId == 0)
      categories.add(categoriesResponse.categoriesData[i]);
  }
  return categories;
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
