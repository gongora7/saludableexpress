import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/products_response.dart';
import 'package:flutter_app1/src/api/responses/stock_response.dart';
import 'package:flutter_app1/src/blocs/products/products_bloc.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/get_stock/get_stock_post.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/product_models/productImage.dart';
import 'package:flutter_app1/src/models/product_models/product_attribute_value.dart';
import 'package:flutter_app1/src/models/product_models/product_attributes.dart';
import 'package:flutter_app1/src/repositories/products_repo.dart';
import 'package:flutter_app1/src/ui/pages/home_page_1.dart';
import 'package:flutter_app1/src/ui/screens/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../../../app_data.dart';
import 'cart_screen.dart';

// ignore: must_be_immutable
class ProductDetailPage extends StatefulWidget {
  Product _product;
  int productId;

  ProductDetailPage(this._product);

  ProductDetailPage.fromSearch(this.productId);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  ProductsBloc _productsBloc;

  List<ProductAttribute> selectedAttributesList = List<ProductAttribute>();

  Box _box;

  int quantity = 1;
  double totalPriceToBuy = 0.0;
  double attributePrice = 0.0;

  @override
  void initState() {
    super.initState();
    _openBox();
    _productsBloc = ProductsBloc(RealProductsRepo());
    if (widget.productId == null) {
      _initLogic();
    } else if (widget.productId != null) {
      _productsBloc.singleProductEventSink
          .add(GetSingleProduct(widget.productId));
    }
  }

  void _initLogic() {
    List<String> attrIds = new List();
    attributePrice = 0.0;
    for (int i = 0; i < widget._product.attributes.length; i++) {
      attrIds.add(widget._product.attributes[i].values[0].productsAttributesId
          .toString());
      if (widget._product.attributes[i].values[0].pricePrefix == "+")
        attributePrice += double.parse(
            widget._product.attributes[i].values[0].price.toString());
      else if (widget._product.attributes[i].values[0].pricePrefix == "-")
        attributePrice -= double.parse(
            widget._product.attributes[i].values[0].price.toString());
    }

    selectedAttributesList = List<ProductAttribute>();
    for (int i = 0; i < widget._product.attributes.length; i++) {
      ProductAttribute attribute = new ProductAttribute();
      attribute.option = widget._product.attributes[i].option;
      attribute.values = List<ProductAttributeValue>();
      attribute.values.add(widget._product.attributes[i].values[0]);
      selectedAttributesList.add(attribute);
    }

    GetStockPost getStockPost =
        GetStockPost(widget._product.productsId, attrIds);
    _productsBloc.stock_event_sink.add(GetStock(getStockPost));
  }

  Future _openBox() async {
    _box = await Hive.openBox('my_cartBox');
    return;
  }

  void _toProductDetailPage(Product product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetailPage(product)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalle de Producto"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30,
              tooltip: 'Buscar',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Search(_toProductDetailPage)));
              },
            ),
            IconButton(
              icon: new Stack(
                children: <Widget>[
                  new Icon(Icons.shopping_cart, size: 30),
                  new Positioned(
                    right: 0,
                    child: new Container(
                      padding: EdgeInsets.all(2),
                      decoration: new BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: new Text(
                        AppData.cartIds.length.toString(),
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              tooltip: 'Carrito',
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              },
            )
            /* IconButton(
              icon: const Icon(Icons.share),
              tooltip: 'Share',
              onPressed: () {},
            ),*/
            /* IconButton(
              icon: const Icon(Icons.favorite_border),
              tooltip: 'Favorite',
              onPressed: () {},
            ),*/
          ],
        ),
        body: (widget.productId == null)
            ? buildBody()
            : StreamBuilder(
                stream: _productsBloc.singleProductStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null) {
                      widget._product = snapshot.data as Product;
                      _initLogic();
                      return buildBody();
                    } else {
                      return buildLoading();
                    }
                  } else {
                    return buildLoading();
                  }
                },
              ));
  }

  Widget buildBody() {
    int discount = 0;
    discount = _calculateDiscount(
        widget._product.productsPrice, widget._product.discountPrice);

    totalPriceToBuy = double.parse(((((discount == 0)
                    ? double.parse(widget._product.productsPrice.toString())
                    : double.parse(widget._product.discountPrice.toString())) +
                attributePrice) *
            quantity)
        .toString());

    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                buildBannersWithData(context, widget._product.productsImage,
                    widget._product.images),
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
                            margin: EdgeInsets.only(top: 4.0),
                            child: Text("$discount% DESC",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            color: Colors.orange.shade400,
                          ),
                        if (widget._product.isFeature == 1)
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 2.0),
                            margin: EdgeInsets.only(top: 4.0),
                            child: Text("RECOMENDADO",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            color: Colors.redAccent[400],
                          ),
                      ],
                    ),
                  ],
                ),
                if (_isNewlyAdded(widget._product.productsDateAdded))
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text("NUEVO",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    color: Colors.red[800],
                  ),
              ]),
              //Divider(color: Colors.redAccent, height: 15.0,),
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        (discount != null && discount != 0)
                            ? Row(
                                children: [
                                  Text(
                                    "\$" +
                                        double.parse(widget
                                                ._product.discountPrice
                                                .toString())
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "\$" +
                                        double.parse(
                                          widget._product.productsPrice
                                              .toString(),
                                        ).toStringAsFixed(2),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.redAccent,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                ],
                              )
                            : Text(
                                "\$" +
                                    double.parse(widget._product.productsPrice
                                            .toString())
                                        .toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                              ),
                        Expanded(child: Container()),
                        if (widget._product.productsType == 0)
                          (widget._product.defaultStock > 0)
                              ? Text("EN STOCK",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green.shade600,
                                      fontSize: 18.0))
                              : Text("NO STOCK",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange.shade700,
                                      fontSize: 18.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                widget._product.productsName,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              if (widget._product.categories.length > 0)
                                Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      widget._product.categories[0]
                                          .categoriesName,
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.0,
                                      ),
                                    )),
                            ],
                          ),
                        ),
                        Container(
                          child: IconButton(
                              icon: IconTheme(
                                  data: IconThemeData(
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(
                                    Icons.remove_circle,
                                    size: 35.0,
                                  )),
                              onPressed: () {
                                if (quantity > 1)
                                  setState(() {
                                    quantity--;
                                  });
                              }),
                        ),
                        Text(
                          quantity.toString(),
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            icon: IconTheme(
                                data: IconThemeData(
                                    color: Theme.of(context).primaryColor),
                                child: Icon(
                                  Icons.add_circle,
                                  size: 35.0,
                                )),
                            onPressed: () {
                              setState(() {
                                quantity++;
                              });
                            }),
                      ],
                    ),
                    if (widget._product.rating != null)
                      GestureDetector(
                        onTap: () {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Valoraciones"),
                          ));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Row(
                            children: [
                              /* FlutterRatingBarIndicator(
                                rating:
                                double.parse(widget._product.rating),
                                itemCount: 5,
                                itemSize: 15.0,
                                itemPadding: EdgeInsets.all(2.0),
                                emptyColor: Colors.grey,
                                fillColor: Theme.of(context).primaryColor,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                               Text("(" +
                                  widget._product.totalUserRated
                                      .toString() +
                                  " Valoraciones)", style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic),),*/
                            ],
                          ),
                        ),
                      ),
                    /* Text("Likes: " +
                        widget._product.productsLiked.toString(), style: TextStyle(fontSize: 17.0, fontStyle: FontStyle.italic)), */
                    Divider(height: 50.0),
                    Text(
                      "Descripción",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Html(
                      data: widget._product.productsDescription,
                    ),
                  ],
                ),
              ),

              if (widget._product.attributes.length > 0)
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Elige tu Producto",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              buildAttributesList(widget._product.attributes),
              SizedBox(
                height: 50.0,
              )
            ],
          ),
        ),
        StreamBuilder(
          stream: _productsBloc.stock_stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                StockResponse response = snapshot.data as StockResponse;
                if (response.success == "1") {
                  attributePrice = 0.0;
                  selectedAttributesList.forEach((element) {
                    if (element.values[0].pricePrefix == "+")
                      attributePrice +=
                          double.parse(element.values[0].price.toString());
                    else if (element.values[0].pricePrefix == "-")
                      attributePrice -=
                          double.parse(element.values[0].price.toString());
                  });
                  totalPriceToBuy = double.parse(((((discount == 0)
                                  ? double.parse(
                                      widget._product.productsPrice.toString())
                                  : double.parse(widget._product.discountPrice
                                      .toString())) +
                              attributePrice) *
                          quantity)
                      .toString());

                  return Positioned(
                    bottom: 8.0,
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                      height: 70,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: (response.stock <= 0 &&
                              widget._product.productsType != 2)
                          ? Colors.orange.shade600
                          : Colors.green.shade600,
                      child: Row(children: [
                        Expanded(
                          child: Text(
                            (widget._product.productsType == 2)
                                ? "Ver Producto"
                                : (response.stock <= 0)
                                    ? "Fuera de Stock"
                                    : "Agregar a Carrito",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        (widget._product.productsType != 2)
                            ? Text("+\$" + totalPriceToBuy.toStringAsFixed(2),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))
                            : IconTheme(
                                data: IconThemeData(color: Colors.white),
                                child: Icon(Icons.open_in_new)),
                      ]),
                      onPressed: () {
                        if (widget._product.productsType !=
                            2) if (response.stock <= 0) {
                          Scaffold.of(context).removeCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Fuera de Stock"),
                          ));
                        } else {
                          Map<dynamic, dynamic> raw = _box.toMap();
                          List cartItems = raw.values.toList();

                          for (int i = 0; i < cartItems.length; i++) {
                            CartEntry entry = cartItems[i];
                            if (entry.id == widget._product.productsId &&
                                entry.attributes ==
                                    jsonEncode(selectedAttributesList
                                            .map((e) => e.toJson())
                                            .toList())
                                        .toString()) {
                              entry.quantity += quantity;
                              _box.putAt(i, entry);
                              Navigator.pop(context);
                              return;
                            }
                          }

                          CartEntry cartEntry = CartEntry();
                          cartEntry.id = widget._product.productsId;
                          cartEntry.quantity = quantity;
                          cartEntry.attributes = jsonEncode(
                              selectedAttributesList
                                  .map((e) => e.toJson())
                                  .toList());
                          _box.add(cartEntry);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  );
                } else
                  return buildLoading();
              } else
                return buildLoading();
            } else
              return buildLoading();
          },
        )
      ],
    );
  }

  int _calculateDiscount(productsPrice, discountPrice) {
    if (discountPrice == null) discountPrice = productsPrice;
    double discount = (productsPrice - discountPrice) / productsPrice * 100;
    return num.parse(discount.toStringAsFixed(0));
  }

  bool _isNewlyAdded(String dateAdded) {
    int diff;
    DateTime dateProduct, dateSystem;

    final f = new DateFormat('yyyy-MM-dd HH:mm:ss');
    dateProduct = f.parse(dateAdded);
    dateSystem = new DateTime.now();

    diff = dateSystem.difference(dateProduct).inDays;

    return diff <= 5;
  }

  Widget buildBannersWithData(
      BuildContext context, String bannerImg, List<ProductImages> images) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 250.0,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: images.length > 1 ? false : false,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 600),
            autoPlayCurve: Curves.linear,
            enlargeCenterPage: false,
            onPageChanged: (index, reason) {},
            scrollDirection: Axis.horizontal,
          ),
          itemCount: images.length,
          itemBuilder: (BuildContext context, int itemIndex, _) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Hero(
                tag: images[itemIndex].productsId,
                child: CachedNetworkImage(
                  imageUrl: ApiProvider.imageBaseUrl + images[itemIndex].image,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress)),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget buildAttributesList(List<ProductAttribute> attributes) {
    return Column(
      children: [
        //Divider(color: Colors.redAccent, height: 15.0,),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: attributes.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(
                      attributes[index].option.name + ":",
                      style: TextStyle(fontSize: 16),
                    )),
                RadioListBuilder(attributes[index].values,
                    selectedAttributesList[index], attributeSelected, index)
              ],
            );
          },
        )
      ],
    );
  }

  void attributeSelected(ProductAttributeValue value, int position) {
    selectedAttributesList[position].values[0] = value;
    List<String> attrIds = new List();
    attributePrice = 0.0;
    selectedAttributesList.forEach((element) {
      attrIds.add(element.values[0].productsAttributesId.toString());
      if (element.values[0].pricePrefix == "+")
        attributePrice += double.parse(element.values[0].price.toString());
      else if (element.values[0].pricePrefix == "-")
        attributePrice -= double.parse(element.values[0].price.toString());
    });
    GetStockPost getStockPost =
        GetStockPost(widget._product.productsId, attrIds);
    _productsBloc.stock_event_sink.add(GetStock(getStockPost));
  }
}

class RadioListBuilder extends StatefulWidget {
  final List<ProductAttributeValue> values;
  final ProductAttribute selectedAttribute;
  final Function(ProductAttributeValue value, int position) attributeSelected;
  final int position;

  const RadioListBuilder(this.values, this.selectedAttribute,
      this.attributeSelected, this.position);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    value = getIndexOfSelectedValue(
        widget.selectedAttribute.values[0].productsAttributesId, widget.values);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return RadioListTile(
          value: index,
          groupValue: value,
          onChanged: (ind) => setState(() {
            value = ind;
            widget.attributeSelected(widget.values[ind], widget.position);
          }),
          title: Text(widget.values[index].value),
          secondary: Text(widget.values[index].pricePrefix +
              "\$" +
              widget.values[index].price.toString()),
          activeColor: Theme.of(context).primaryColor,
        );
      },
      itemCount: widget.values.length,
    );
  }

  int getIndexOfSelectedValue(
      int productsAttributesId, List<ProductAttributeValue> values) {
    for (int i = 0; i < values.length; i++) {
      if (productsAttributesId == values[i].productsAttributesId) {
        return i;
      }
    }
    return 0;
  }
}
