import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/models/categories_response/category.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'shop.dart';

// ignore: must_be_immutable
class CategoryPage extends StatefulWidget {
  int categoryType = 1;
  bool isHeaderVisible = false;
  final Function(int categoryId) _toShopFromCategory;

  CategoryPage(
      this.categoryType, this.isHeaderVisible, this._toShopFromCategory);

  @override
  _CategoryPageState createState() =>
      _CategoryPageState(categoryType, isHeaderVisible);
}

class _CategoryPageState extends State<CategoryPage> {
  int categoryType;
  bool isHeaderVisible;

  _CategoryPageState(this.categoryType, this.isHeaderVisible);

  @override
  void initState() {
    super.initState();

    // ignore: close_sinks
    final categoryBloc = BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return isHeaderVisible
        ? Scaffold(
            appBar: AppBar(
              title: Text("Categorías"),
            ),
            body: buildUI(),
          )
        : buildUI();
  }

  Widget buildUI() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          if (state is CategoriesInitial) {
            return buildLoading();
          } else if (state is CategoriesLoading) {
            return buildLoading();
          } else if (state is CategoriesLoaded) {
            switch (widget.categoryType) {
              case 1:
                return buildCategory1(
                    context, getParentCategories(state.categoriesResponse));
                break;
              case 2:
                return buildCategory2(
                    context, getParentCategories(state.categoriesResponse));
                break;
              case 3:
                return buildCategory3(
                    context, getParentCategories(state.categoriesResponse));
                break;
              case 4:
                return buildCategory4(
                    context, getParentCategories(state.categoriesResponse));
                break;
              case 5:
                return buildCategory5(
                    context, getParentCategories(state.categoriesResponse));
                break;
              default:
                return buildCategory6(
                    context, getParentCategories(state.categoriesResponse));
                break;
            }
          } else if (state is CategoriesError) {
            return buildLoading();
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }

  List<Category> getParentCategories(CategoriesResponse categoriesResponse) {
    List<Category> categories = [];
    for (int i = 0; i < categoriesResponse.categoriesData.length; i++) {
      if (categoriesResponse.categoriesData[i].parentId == 0)
        categories.add(categoriesResponse.categoriesData[i]);
    }
    return categories;
  }

  Widget buildCategory1(BuildContext context, List<Category> categories) {
    int count;
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      count = 3;
    else
      count = 2;
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            widget._toShopFromCategory(categories[index].categoriesId);
          },
          child: Container(
            margin: EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 140.0,
                      height: 140.0,
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(

                          border: Border.all(color: Colors.blueGrey[200], width: 5.0),
                          boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          )],
                          
                          shape: BoxShape.circle, color: Colors.grey.shade300),

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(70.0),
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
                ),
                Text(categories[index].categoriesName),
                Text(categories[index].totalProducts.toString() + " Productos"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory2(BuildContext context, List<Category> categories) {
    int count;
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      count = 2;
    else
      count = 1;
    return GridView.builder(
      padding: EdgeInsets.all(4.0),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        childAspectRatio: 2.0,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            widget._toShopFromCategory(categories[index].categoriesId);
          },
          child: Container(
            margin: EdgeInsets.all(2.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.maxFinite,
                  child: CachedNetworkImage(
                    imageUrl:
                        ApiProvider.imageBaseUrl + categories[index].image,
                    fit: BoxFit.fitWidth,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                    )),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      categories[index].categoriesName,
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                    Text(
                      categories[index].totalProducts.toString() + " Productos",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory3(BuildContext context, List<Category> categories) {
    int count;
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      count = 3;
    else
      count = 2;
    return GridView.builder(
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: count,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            widget._toShopFromCategory(categories[index].categoriesId);
          },
          child: Container(
            margin: EdgeInsets.all(2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 100.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      // child: Hero(
                      //   tag: categories[index].categoriesId,
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiProvider.imageBaseUrl + categories[index].image,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      // ),
                    ),
                  ),
                ),
                Text(categories[index].categoriesName),
                Text(categories[index].totalProducts.toString() + " Productos"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory4(BuildContext context, List<Category> categories) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            widget._toShopFromCategory(categories[index].categoriesId);
          },
          child: Container(
            margin: EdgeInsets.all(4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 100.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: CachedNetworkImage(
                      imageUrl:
                          ApiProvider.imageBaseUrl + categories[index].image,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categories[index].categoriesName),
                    Text(categories[index].totalProducts.toString() +
                        " Productos"),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory5(BuildContext context, List<Category> categories) {
    return ListView.builder(
      padding: EdgeInsets.all(3.0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            widget._toShopFromCategory(categories[index].categoriesId);
          },
          child: Container(
            margin: EdgeInsets.all(6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
                        imageUrl:
                            ApiProvider.imageBaseUrl + categories[index].image,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(categories[index].categoriesName),
                    Text(categories[index].totalProducts.toString() +
                        " Products"),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildCategory6(BuildContext context, List<Category> categories) {
    return ListView.builder(
      padding: EdgeInsets.all(3.0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            widget._toShopFromCategory(categories[index].categoriesId);
          },
          child: Container(
            padding: EdgeInsets.all(12.0),
            color: Colors.black12,
            margin: EdgeInsets.all(1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  categories[index].categoriesName,
                  style: TextStyle(color: Colors.black, fontSize: 21),
                ),
                Expanded(child: SizedBox()),
                Center(
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            ApiProvider.imageBaseUrl + categories[index].image,
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}
