import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/blocs/search/search_bloc.dart';
import 'package:flutter_app1/src/blocs/search/search_event.dart';
import 'package:flutter_app1/src/blocs/search/search_state.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/categories_response/category.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/search_product.dart';
import 'package:flutter_app1/src/ui/pages/shop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'product_detail_page.dart';

class Search extends StatefulWidget {
  final Function(Product product) _toProductDetailPage;

  Search(this._toProductDetailPage);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = true;
  String searchQuery = "Search query";

  SearchBloc searchBloc;

  @override
  void initState() {
    super.initState();

    searchBloc = BlocProvider.of<SearchBloc>(context);
    // ignore: close_sinks
    final categoryBloc = BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: _isSearching ? const BackButton() : Container(),
          title: _isSearching ? _buildSearchField() : _buildTitle(context),
          actions: _buildActions(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //buildProductList(),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Container();
                  } else if (state is SearchLoading) {
                    return buildLoading();
                  } else if (state is SearchLoaded) {
                    if (state.searchResponse.productData != null)
                      return buildProductsSection(
                          state.searchResponse.productData.products);
                    else
                      return Container();
                  } else if (state is SearchError) {
                    return buildLoading();
                  } else {
                    return buildLoading();
                  }
                },
              ),
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesInitial) {
                    return buildLoading();
                  } else if (state is CategoriesLoading) {
                    return buildLoading();
                  } else if (state is CategoriesLoaded) {
                    return buildColumnWithData(
                        context, getParentCategories(state.categoriesResponse));
                  } else if (state is CategoriesError) {
                    return buildLoading();
                  } else {
                    return buildLoading();
                  }
                },
              ),
            ],
          ),
        ));
  }

  Widget buildProductsSection(List<SearchProduct> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "Productos",
              style: TextStyle(fontSize: 16.0),
            )),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            if (products.isNotEmpty) {
              return ListTile(
                leading: Container(
                  width: 70.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      imageUrl: ApiProvider.imageBaseUrl +
                          products[index].productsImage,
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                title: Text(products[index].productsName),
                subtitle: Text((products[index].categories.isNotEmpty)
                    ? products[index].categories[0].categoriesName
                    : ""),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage.fromSearch(
                              products[index].productsId)));
                },
              );
            } else
              return Container();
          },
        ),
        Padding(
            padding: EdgeInsets.all(25.0),
            child: Text(
              "Categorías",
              style: TextStyle(fontSize: 16.0),
            )),
      ],
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

  Widget buildColumnWithData(BuildContext context, List<Category> categories) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.all(16.0),
          onTap: () {
            //widget._toShopFromCategory(categories[index].categoriesId);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Shop(categories[index].categoriesId,
                        "newest", true, widget._toProductDetailPage)));
          },
          leading: Container(
            width: 70.0,
            height: 70.0,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: ApiProvider.imageBaseUrl + categories[index].image,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          title: Text(
            categories[index].categoriesName.toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            categories[index].totalProducts.toString() +
                " Productos".toUpperCase(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.navigate_next),
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: "Buscando...",
        border: InputBorder.none,
      ),
      onSubmitted: (value) {
        searchBloc.add(PerformSearch(value.toString().trim()));
      },
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    /*if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];*/
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  Widget _buildTitle(BuildContext context) {
    return Text("Buscar");
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int _calculateDiscount(productsPrice, discountPrice) {
    if (discountPrice == null) discountPrice = productsPrice;
    double discount = (productsPrice - discountPrice) / productsPrice * 100;
    return num.parse(discount.toStringAsFixed(0));
  }

  bool _isNewlyAdded(String dateAdded) {
    int diff;
    int days;
    DateTime dateProduct, dateSystem;

    final f = new DateFormat('yyyy-MM-dd HH:mm:ss');
    dateProduct = f.parse(dateAdded);
    dateSystem = new DateTime.now();

    diff = dateSystem.difference(dateProduct).inDays;

    return diff <= 5;
  }
}
