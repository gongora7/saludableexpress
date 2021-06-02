import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/filters_response.dart';
import 'package:flutter_app1/src/api/responses/like_product_response.dart';
import 'package:flutter_app1/src/api/responses/products_response.dart';
import 'package:flutter_app1/src/blocs/products/products_bloc.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/filters_models/filters.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/product_models/product_post_filter.dart';
import 'package:flutter_app1/src/models/product_models/product_post_model.dart';
import 'package:flutter_app1/src/models/product_models/product_post_price.dart';
import 'package:flutter_app1/src/repositories/products_repo.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Products extends StatefulWidget {
  String type = "Newest";
  String categoryId = "";
  bool isHorizontal = false;
  bool isBottomBarVisible = false;
  bool isNextPageAutoLoad = false;
  final Function(Product product) _toProductDetailPage;

  Products(
      this.type,
      this.categoryId,
      this.isHorizontal,
      this.isBottomBarVisible,
      this.isNextPageAutoLoad,
      this._toProductDetailPage);

  @override
  _ProductsState createState() => _ProductsState(
      this.type, this.categoryId, this.isHorizontal, this._toProductDetailPage);
}

class _ProductsState extends State<Products>
    with AutomaticKeepAliveClientMixin<Products> {
  String type = "Newest";
  String categoryId = "";
  ProductsBloc _productsBloc;
  ProductPostModel postModel;
  bool isHorizontal = false;
  bool isPageLoading = false;
  final _scrollController = ScrollController();
  bool isGrid = true;
  List<List<bool>> selectedFiltersCheckmarks = List<List<bool>>();
  RangeValues selectedPriceRange;

  final Function(Product product) _toProductDetailPage;
  int dataSize = 0;

  Box _box;

  _ProductsState(
      this.type, this.categoryId, this.isHorizontal, this._toProductDetailPage);

  @override
  void dispose() {
    super.dispose();
    _productsBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    _box = Hive.box("my_cartBox");

    _productsBloc = ProductsBloc(RealProductsRepo());
    _getProducts();

    _productsBloc.likeProductStream.listen((event) {
      LikeProductResponse response = event;
      if (response.success == "1" && widget.type == "wishlist") {
        setState(() {
          _getProducts();
        });
      }
    });

    //productsBloc.add((type == "") ? GetProducts(postModel) : GetTopSellerProducts(postModel));
  }

  _getProducts() {
    postModel = ProductPostModel();
    postModel.customersId =
        AppData.user != null ? AppData.user.id.toString() : "";
    postModel.currencyCode = "USD";
    postModel.languageId = 1;
    postModel.pageNumber = 0;
    postModel.type = this.type;
    postModel.categoriesId = this.categoryId;

    _productsBloc.products_event_sink.add(GetProducts(postModel));
    if (!isHorizontal)
      _productsBloc.filters_event_sink.add(GetFilters(categoryId));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _productsBloc.products_stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            if (isHorizontal) {
              return buildHorizontalList(snapshot.data as ProductsResponse);
            }
            return (isGrid)
                ? buildGridView(snapshot.data as ProductsResponse)
                : buildListView(snapshot.data as ProductsResponse);
          } else {
            return buildLoading();
          }
        } else {
          return buildLoading();
        }
      },
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildGridView(ProductsResponse productsResponse) {
    int count;
    if (MediaQuery.of(context).orientation == Orientation.landscape)
      count = 3;
    else
      count = 2;
    if (productsResponse.productData.length != dataSize) {
      isPageLoading = false;
      dataSize = productsResponse.productData.length;
    }
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: widget.isNextPageAutoLoad ? _scrollController : null,
            slivers: [
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      myCard(productsResponse.productData[index]),
                  childCount: productsResponse.productData.length,
                ),
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: count,
                  childAspectRatio: 0.75,
                ),
              ),
              if (productsResponse.productData.length % 10 == 0)
                SliverToBoxAdapter(
                  child: (isPageLoading)
                      ? buildLoading()
                      : widget.isNextPageAutoLoad
                          ? SizedBox(
                              height: 60.0,
                            )
                          : Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    postModel.pageNumber++;
                                    _productsBloc.products_event_sink
                                        .add(GetNextPageProducts(postModel));
                                    isPageLoading = true;
                                  });
                                },
                                icon: IconTheme(
                                    data: IconThemeData(color: Colors.white),
                                    child: Icon(Icons.refresh)),
                              ),
                            ),
                ),
            ],
          ),
        ),
        if (widget.isBottomBarVisible) buildBottomBar(),
      ],
    );
  }

  Widget buildBottomBar() {
    return Container(
        height: 45.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FlatButton(
                height: 45,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          ListTile(
                              onTap: () {
                                this.type = "Newest";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Nuevos')),
                          ListTile(
                              onTap: () {
                                this.type = "a to z";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('A - Z')),
                          ListTile(
                              onTap: () {
                                this.type = "z to a";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Z - A')),
                          ListTile(
                              onTap: () {
                                this.type = "high to low";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Precio: Alto - Bajo')),
                          ListTile(
                              onTap: () {
                                this.type = "low to high";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Precio: Bajo - Alto')),
                        /*  ListTile(
                              onTap: () {
                                this.type = "top seller";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Top Seller')),
                          ListTile(
                              onTap: () {
                                this.type = "special";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Super Deals')),
                          ListTile(
                              onTap: () {
                                this.type = "most liked";
                                _getProducts();
                                Navigator.pop(context);
                              },
                              title: Text('Most Liked')), */
/*
                          GestureDetector(
                            child: ListTile(title: Text('Flash Sale')),
                            onTap: () {
                              this.type = "Newest";
                              _getProducts();
                              Navigator.pop(context);
                            },
                          ),
*/
                        ],
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.filter_list),
                    SizedBox(
                      width: 14.0,
                    ),
                    Expanded(child: Text(type))
                  ],
                ),
              ),
            ),
           /* IconButton(
              icon: Icon((!isGrid) ? Icons.border_all : Icons.list),
              tooltip: 'List / Grid',
              onPressed: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
            ),*/
            StreamBuilder(
                stream: _productsBloc.filters_stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      return IconButton(
                        icon: const Icon(Icons.filter_alt_outlined),
                        tooltip: 'Filter',
                        onPressed: () {
                          buildFiltersDialog(
                              context, snapshot.data as FiltersResponse);
                        },
                      );
                    } else {
                      return buildLoading();
                    }
                  } else {
                    return buildLoading();
                  }
                }),
          ],
        ));
  }

  Widget buildHorizontalList(ProductsResponse data) {
    return ListView.builder(
      itemCount: data.productData.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: 160,
          child: myCard(data.productData[index]),
        );
      },
    );
  }

  Widget myCard(Product product) {
    int discount =
        _calculateDiscount(product.productsPrice, product.discountPrice);


    return Container(
      padding: EdgeInsets.all(5.0),
      
      child: GestureDetector(
        onTap: () {
          _toProductDetailPage(product);
        },
        child: new Card(
          
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: Center(
                        child: Hero(
                         tag: product.productsId,
                        child: CachedNetworkImage(
                          imageUrl:
                              ApiProvider.imageBaseUrl + product.productsImage,
                          fit: BoxFit.contain,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                        ),

                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product.productsName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                            Row(
                              children: [
                                Expanded(
                                  child: (discount != null && discount != 0)
                                      ? Row(
                                          children: [
                                            Text(
                                              AppData.currencySymbol +
                                                  double.parse(product
                                                          .productsPrice
                                                          .toString())
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.lineThrough),
                                            ),
                                            SizedBox(width: 4),
                                            Text(AppData.currencySymbol +
                                                double.parse(product.discountPrice
                                                        .toString())
                                                    .toStringAsFixed(2)),
                                          ],
                                        )
                                      : Text(AppData.currencySymbol +
                                          double.parse(product.productsPrice
                                                  .toString())
                                              .toStringAsFixed(2)),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (product.isLiked == "0")
                                          _productsBloc.likeEventSink.add(
                                              LikeProduct(product.productsId));
                                        else
                                          _productsBloc.likeEventSink.add(
                                              UnlikeProduct(product.productsId));
                                        product.isLiked =
                                            (product.isLiked == "1") ? "0" : "1";
                                      });
                                      Scaffold.of(context)
                                          .removeCurrentSnackBar();
                                      Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text("Liked"),
                                      ));
                                    },
                                    child: IconTheme(
                                        data: IconThemeData(
                                            color:
                                                Theme.of(context).primaryColor),
                                        child: Icon((product.isLiked == "1")
                                            ? Icons.favorite
                                            : Icons.favorite_border))),
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        child: FlatButton(

                          onPressed: () {
                              if (widget.type == "wishlist") {
                                setState(() {
                                  _productsBloc.likeEventSink
                                      .add(UnlikeProduct(product.productsId));
                                });
                                //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Removed")));
                                return;
                              }
                              if (product.productsType != 0) {
                                _toProductDetailPage(product);
                              } else {
                                if (product.defaultStock > 0) {
                                  Map<dynamic, dynamic> raw = _box.toMap();
                                  List cartItems = raw.values.toList();

                                  for (int i = 0; i < cartItems.length; i++) {
                                    CartEntry entry = cartItems[i];
                                    if (entry.id == product.productsId) {
                                      entry.quantity++;
                                      _box.putAt(i, entry);
                                      return;
                                    }
                                  }

                                  CartEntry cartEntry = CartEntry();
                                  cartEntry.id = product.productsId;
                                  cartEntry.quantity = 1;
                                  cartEntry.attributes = "[]";
                                  _box.add(cartEntry);
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Producto Agregado al carrito"),
                                  ));
                                } else {
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Fuera de Stock"),
                                  ));
                                }
                              }
                            },
                            color: (product.defaultStock <= 0 &&
                                    product.productsType == 0)
                                ? Colors.redAccent[400]
                                : Colors.blueAccent[400],
                            child: Text(
                              (widget.type == "wishlist")
                                  ? "Eliminar"
                                  : (product.productsType != 0)
                                      ? "Ver Producto"
                                      : (product.defaultStock > 0)
                                          ? "Agregar a Carrito"
                                          : "Fuera de Stock",
                              style: TextStyle(color: Colors.white),
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (discount != null && discount != 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 2.0),
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text("$discount% OFF",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          color: Colors.redAccent[400],
                        ),
                      if (product.isFeature == 1)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 2.0),
                          margin: EdgeInsets.only(top: 2.0),
                          child: Text("RECOMENDADO",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                          color: Colors.redAccent[400],
                        ),
                    ],
                  ),
                ],
              ),
              if (_isNewlyAdded(product.productsDateAdded))
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                  margin: EdgeInsets.all(2.0),
                  child: Text("NUEVO",
                      style: TextStyle(color: Colors.white, fontSize: 12)),
                  color: Colors.red[800],
                ),
              if (AppData.cartIds.contains(product.productsId))
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    color: Colors.grey[100],
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      "assets/images/check.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myCardList(Product product) {
    int discount =
        _calculateDiscount(product.productsPrice, product.discountPrice);

    return GestureDetector(
      onTap: () {
        _toProductDetailPage(product);
      },
      child: new Card(
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 140,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    //child: Hero(
                    //tag: product.productsId,
                    child: CachedNetworkImage(
                      imageUrl:
                          ApiProvider.imageBaseUrl + product.productsImage,
                      fit: BoxFit.contain,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                //),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlutterRatingBarIndicator(
                                rating: double.parse(product.rating),
                                itemCount: 5,
                                itemSize: 15.0,
                                itemPadding: EdgeInsets.all(2.0),
                                emptyColor: Colors.grey,
                                fillColor: Theme.of(context).primaryColor,
                              ),
                              if (product.categories.length > 0)
                                Text(product.categories[0].categoriesName),
                              Text(product.productsName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                              Row(
                                children: [
                                  Expanded(
                                    child: (discount != null && discount != 0)
                                        ? Row(
                                            children: [
                                              Text(
                                                AppData.currencySymbol +
                                                    double.parse(product
                                                            .productsPrice
                                                            .toString())
                                                        .toStringAsFixed(2),
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              SizedBox(width: 4),
                                              Text(AppData.currencySymbol +
                                                  double.parse(product
                                                          .discountPrice
                                                          .toString())
                                                      .toStringAsFixed(2)),
                                            ],
                                          )
                                        : Text(AppData.currencySymbol +
                                            double.parse(product.productsPrice
                                                    .toString())
                                                .toStringAsFixed(2)),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (product.isLiked == "0")
                                            _productsBloc.likeEventSink.add(
                                                LikeProduct(
                                                    product.productsId));
                                          else
                                            _productsBloc.likeEventSink.add(
                                                UnlikeProduct(
                                                    product.productsId));
                                          product.isLiked =
                                              (product.isLiked == "1")
                                                  ? "0"
                                                  : "1";
                                        });
                                        Scaffold.of(context)
                                            .removeCurrentSnackBar();
                                        Scaffold.of(context).showSnackBar(
                                            SnackBar(content: Text("Liked")));
                                      },
                                      child: IconTheme(
                                          data: IconThemeData(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          child: Icon((product.isLiked == "1")
                                              ? Icons.favorite
                                              : Icons.favorite_border))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            onPressed: () {
                              if (widget.type == "wishlist") {
                                setState(() {
                                  _productsBloc.likeEventSink
                                      .add(UnlikeProduct(product.productsId));
                                  _getProducts();
                                });
                                //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Removed")));
                                return;
                              }
                              if (product.productsType != 0) {
                                _toProductDetailPage(product);
                              } else {
                                if (product.defaultStock > 0) {
                                  Map<dynamic, dynamic> raw = _box.toMap();
                                  List cartItems = raw.values.toList();

                                  for (int i = 0; i < cartItems.length; i++) {
                                    CartEntry entry = cartItems[i];
                                    if (entry.id == product.productsId) {
                                      entry.quantity++;
                                      _box.putAt(i, entry);
                                      return;
                                    }
                                  }

                                  CartEntry cartEntry = CartEntry();
                                  cartEntry.id = product.productsId;
                                  cartEntry.quantity = 1;
                                  cartEntry.attributes = "[]";
                                  _box.add(cartEntry);
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Product Added to Cart"),
                                  ));
                                } else {
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Out of Stock"),
                                  ));
                                }
                              }
                            },
                            color: (product.defaultStock <= 0 &&
                                    product.productsType == 0)
                                ? Colors.red[800]
                                : Colors.green[800],
                            child: Text(
                              (widget.type == "wishlist")
                                  ? "Eliminar"
                                  : (product.productsType != 0)
                                      ? "Ver Producto"
                                      : (product.defaultStock > 0)
                                          ? "Agregar a Carrito"
                                          : "Fuera de Stock",
                              style: TextStyle(color: Colors.white),
                            ),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap),
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (discount != null && discount != 0)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 2.0),
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text("$discount% DESC",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        color: Colors.green[800],
                      ),
                    if (product.isFeature == 1)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 2.0),
                        margin: EdgeInsets.only(top: 2.0),
                        child: Text("RECOMENDADO",
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        color: Colors.blueAccent[400],
                      ),
                  ],
                ),
              ],
            ),
            if (_isNewlyAdded(product.productsDateAdded))
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                margin: EdgeInsets.all(2.0),
                child: Text("NUEVO",
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                color: Colors.red[800],
              ),
            if (AppData.cartIds.contains(product.productsId))
              Opacity(
                opacity: 0.5,
                child: Container(
                  color: Colors.grey,
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset(
                    "assets/images/check.png",
                    fit: BoxFit.none,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildListView(ProductsResponse productsResponse) {
    if (productsResponse.productData.length != dataSize) {
      isPageLoading = false;
      dataSize = productsResponse.productData.length;
    }
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            controller: widget.isNextPageAutoLoad ? _scrollController : null,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Container(
                      height: 140,
                      child: myCardList(productsResponse.productData[index])),
                  childCount: productsResponse.productData.length,
                ),
              ),
              if (productsResponse.productData.length % 10 == 0)
                SliverToBoxAdapter(
                  child: (isPageLoading)
                      ? buildLoading()
                      : widget.isNextPageAutoLoad
                          ? SizedBox(
                              height: 60.0,
                            )
                          : Container(
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    postModel.pageNumber++;
                                    _productsBloc.products_event_sink
                                        .add(GetNextPageProducts(postModel));
                                    isPageLoading = true;
                                  });
                                },
                                icon: IconTheme(
                                    data: IconThemeData(color: Colors.white),
                                    child: Icon(Icons.refresh)),
                              ),
                            ),
                ),
            ],
          ),
        ),
        if (widget.isBottomBarVisible) buildBottomBar(),
      ],
    );
  }

  Widget buildItem(ProductsResponse productsResponse, int position) {
    return Card(
      child: Text(productsResponse.productData[position].productsName),
    );
  }

  @override
  bool get wantKeepAlive => true;

  buildFiltersDialog(BuildContext context, FiltersResponse data) {
    if (selectedFiltersCheckmarks.length <= 0) {
      List<List<bool>> temp1 = List<List<bool>>();
      for (int i = 0; i < data.filters.length; i++) {
        List<bool> temp2 = List<bool>();
        for (int j = 0; j < data.filters[i].values.length; j++) {
          temp2.add(false);
        }
        temp1.add(temp2);
      }

      selectedFiltersCheckmarks = temp1;

      selectedPriceRange =
          RangeValues(1, double.parse(data.maxPrice.toString()));
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            scrollable: true,
            contentPadding: EdgeInsets.all(0.0),
            content: FilterDialogBuilder(data, _onFiltersSelected,
                selectedFiltersCheckmarks, selectedPriceRange),
          );
        });
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

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!isPageLoading)
        setState(() {
          postModel.pageNumber++;
          _productsBloc.products_event_sink.add(GetNextPageProducts(postModel));
          isPageLoading = true;
          print("Next Page. ");
        });
    }
  }

  void _onFiltersSelected(
      List<ProductPostFilter> selectedFilters,
      ProductPostPrice selectedPrice,
      List<List<bool>> selectedFiltersCheckmarks) {
    this.selectedFiltersCheckmarks = selectedFiltersCheckmarks;
    this.selectedPriceRange = RangeValues(
        double.parse(selectedPrice.minPrice.toString()),
        double.parse(selectedPrice.maxPrice.toString()));

/*
    postModel = ProductPostModel();
    postModel.currencyCode = "USD";
    postModel.languageId = 1;
    postModel.pageNumber = 0;
    postModel.type = this.type;
    postModel.categoriesId = this.categoryId;
    postModel.filters = selectedFilters;
    postModel.price = selectedPrice;

    _productsBloc.products_event_sink.add(GetProducts(postModel));
*/
  }
}

class FilterDialogBuilder extends StatefulWidget {
  final FiltersResponse data;
  final Function(
      List<ProductPostFilter> selectedFilters,
      ProductPostPrice selectedPrice,
      List<List<bool>> selectedFiltersCheckmarks) _onFiltersSelected;
  final List<List<bool>> selectedFiltersCheckmarks;
  final RangeValues selectedPriceRange;

  FilterDialogBuilder(this.data, this._onFiltersSelected,
      this.selectedFiltersCheckmarks, this.selectedPriceRange);

  @override
  _FilterDialogBuilderState createState() => _FilterDialogBuilderState();
}

class _FilterDialogBuilderState extends State<FilterDialogBuilder> {
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels = RangeLabels('\$1', "\$100");
  List<List<bool>> selectedFiltersCheckmarks = List<List<bool>>();

  @override
  void initState() {
    super.initState();
    selectedFiltersCheckmarks = widget.selectedFiltersCheckmarks;
    values = widget.selectedPriceRange;

    values = widget.selectedPriceRange;
    labels = RangeLabels(
        AppData.currencySymbol +
            widget.selectedPriceRange.start.toStringAsFixed(2),
        AppData.currencySymbol +
            widget.selectedPriceRange.end.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.70,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Product Price")),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: [
                        Text(
                          AppData.currencySymbol +
                              values.start.toStringAsFixed(2),
                          style: TextStyle(fontSize: 12),
                        ),
                        Expanded(child: Container()),
                        Text(
                          AppData.currencySymbol +
                              values.end.toStringAsFixed(2),
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  RangeSlider(
                      activeColor: Theme.of(context).primaryColor,
                      min: 1,
                      max: double.parse(widget.data.maxPrice.toString()),
                      values: values,
                      labels: labels,
                      onChanged: (value) {
                        setState(() {
                          values = value;
                          labels = RangeLabels(
                              "${value.start.toInt().toString()}\$",
                              "${value.end.toInt().toString()}\$");
                        });
                      }),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.data.filters.length,
                    itemBuilder: (context, i) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                            color: Colors.grey,
                          ),
                          Padding(
                              padding: EdgeInsets.all(16),
                              child: Text(
                                  widget.data.filters[i].option.name + ":")),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.data.filters[i].values.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                title: Text(
                                  widget.data.filters[i].values[index].value,
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: selectedFiltersCheckmarks[i][index],
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedFiltersCheckmarks[i][index] =
                                        newValue;
                                  });
                                },
                                controlAffinity: ListTileControlAffinity
                                    .trailing, //  <-- leading Checkbox
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 45.0,
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    height: 45,
                    color: Colors.grey,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Expanded(
                child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    height: 45,
                    color: Colors.green[800],
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      ProductPostPrice selectedPrice = ProductPostPrice();
                      selectedPrice.minPrice = 1;
                      selectedPrice.maxPrice =
                          double.parse(widget.data.maxPrice.toString());
                      widget._onFiltersSelected(List<ProductPostFilter>(),
                          selectedPrice, getEmptyChckmarks());
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Limpiar",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Expanded(
                child: FlatButton(
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    height: 45,
                    color: Theme.of(context).primaryColor,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      ProductPostPrice selectedPrice = ProductPostPrice();
                      selectedPrice.minPrice = values.start;
                      selectedPrice.maxPrice = values.end;
                      widget._onFiltersSelected(
                          getSelectedFilters(widget.data.filters),
                          selectedPrice,
                          selectedFiltersCheckmarks);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Aplicar",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  List<ProductPostFilter> getSelectedFilters(List<Filters> filters) {
    List<ProductPostFilter> list = List<ProductPostFilter>();

    for (int i = 0; i < selectedFiltersCheckmarks.length; i++) {
      for (int j = 0; j < selectedFiltersCheckmarks[i].length; j++) {
        if (selectedFiltersCheckmarks[i][j]) {
          ProductPostFilter filter = ProductPostFilter();
          filter.name = filters[i].option.name;
          filter.value = filters[i].values[j].value;
          list.add(filter);
        }
      }
    }

    return list;
  }

  List<List<bool>> getEmptyChckmarks() {
    List<List<bool>> temp1 = List<List<bool>>();
    for (int i = 0; i < widget.data.filters.length; i++) {
      List<bool> temp2 = List<bool>();
      for (int j = 0; j < widget.data.filters[i].values.length; j++) {
        temp2.add(false);
      }
      temp1.add(temp2);
    }
    return temp1;
  }
}
