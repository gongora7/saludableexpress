import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/blocs/products/products_bloc.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/product_models/product_attributes.dart';
import 'package:flutter_app1/src/repositories/products_repo.dart';
import 'package:flutter_app1/src/ui/screens/product_detail_page.dart';
import 'package:flutter_app1/src/ui/screens/search_page.dart';
import 'package:flutter_app1/src/ui/screens/shipping_address_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  ProductsBloc _productsBloc;
  Box _box;
  List<CartEntry> list;

  @override
  void initState() {
    super.initState();
    _box = Hive.box("my_cartBox");
    _productsBloc = ProductsBloc(RealProductsRepo());
  }

  @override
  void dispose() {
    super.dispose();
    _productsBloc.dispose();
  }

  void _toProductDetailPage(Product product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetailPage(product)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito"),
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
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: _box.listenable(),
        builder: (BuildContext context, box, Widget child) {
          if (list == null) {
            list = new List<CartEntry>();
            Map<dynamic, dynamic> raw = box.toMap();
            raw.values.forEach((element) {
              list.add(element);
            });
            _productsBloc.cart_products_event_sink.add(GetCartProducts(list));
          }
          return buildCartBody(list);
        },
      ),
    );
  }

  Widget buildCartBody(list) {
    return (list.length > 0)
        ? StreamBuilder(
            stream: _productsBloc.cart_product_stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null) {
                  List<Product> data = snapshot.data as List<Product>;

                  double subtotalPrice = 0.0;
                  double discountPrice = 0.0;
                  double totalPrice = 0.0;

                  for (int i = 0; i < data.length; i++) {
                    Product product = data[i];
                    CartEntry cartEntry = list[i];
                    int isDiscount = _calculateDiscount(
                        product.productsPrice, product.discountPrice);

                    List<ProductAttribute> cartProductAttributes =
                        new List<ProductAttribute>();
                    json.decode(cartEntry.attributes).forEach((v) {
                      cartProductAttributes
                          .add(new ProductAttribute.fromJson(v));
                    });

                    if (data[i].productsId != null) {
                      double attrsPrice = 0.0;
                      cartProductAttributes.forEach((element) {
                        attrsPrice +=
                            double.parse(element.values[0].price.toString());
                      });
                      subtotalPrice +=
                          ((double.parse(product.productsPrice.toString()) +
                                  attrsPrice) *
                              cartEntry.quantity);
                      if (isDiscount != null && isDiscount != 0) {
                        discountPrice +=
                            (double.parse(product.productsPrice.toString()) -
                                    double.parse(
                                        product.discountPrice.toString())) *
                                cartEntry.quantity;
                      }
                      totalPrice += (((isDiscount != null && isDiscount != 0)
                              ? double.parse(product.discountPrice.toString())
                              : double.parse(product.productsPrice.toString()) +
                                  attrsPrice) *
                          cartEntry.quantity);
                    } else {
                      _productsBloc.cart_products_event_sink
                          .add(DeleteCartProduct(i));
                      _box.deleteAt(i);
                      break;
                    }
                  }

                  return Column(
                    children: [
                      Expanded(child: buildProductsList(data, list)),
                      Container(
                        decoration: new BoxDecoration(
                            color: Colors.orange.shade50,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(247, 121, 34, 1)
                                    .withOpacity(0.3),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(25),
                              child: Column(
                                children: [
                                  Row(children: [
                                    Text(
                                      "Subtotal".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                        "\$" + subtotalPrice.toStringAsFixed(2),
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(247, 121, 34, 1),
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold)),
                                  ]),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  //Divider(height: 3.0),
                                  Row(children: [
                                    Text("Descuento".toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold)),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      "\$" + discountPrice.toStringAsFixed(2),
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(247, 121, 34, 1),
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  //Divider(height: 3.0),
                                  Row(children: [
                                    Text(
                                      "Total".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(child: SizedBox()),
                                    Text(
                                      "\$" + totalPrice.toStringAsFixed(2),
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(247, 121, 34, 1),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: FlatButton(
                                color: Color.fromRGBO(20, 137, 54, 1),
                                height: 70.0,
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                child: Text(
                                  "Proceder al pago",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.0),
                                ),
                                onPressed: () async {
                                  if (AppData.user == null) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text(
                                      "Inicia Sesión para continuar",
                                      style: TextStyle(fontSize: 14),
                                    )));
                                    return;
                                  }
                                  String message = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ShippingAddress(
                                        cartEntries: list,
                                        cartProducts: data,
                                        totalPrice: totalPrice,
                                      ),
                                    ),
                                  );
                                  if (message != null && message.isNotEmpty) {
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(
                                        new SnackBar(
                                            content: new Text(message)));
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return buildLoading();
                }
              } else {
                return buildLoading();
              }
            },
          )
        : Container(
            margin: EdgeInsets.all(16.0),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: IconTheme(
                          data: IconThemeData(color: Colors.blueAccent[400]),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: 100.0,
                          )),
                    ),
                    Text(
                      "Carrito Vacio",
                      style: TextStyle(
                          fontSize: 21.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text("Tu carrito esta vacío! Continua comprando."),
                    SizedBox(
                      height: 15.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.0),
                      child: FlatButton(
                        color: Color.fromRGBO(20, 137, 54, 1),
                        height: 50.0,
                        child: Text(
                          "Ver más productos saludables",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }

  Widget buildProductsList(List<Product> products, List<CartEntry> list) {
    return Container(
      color: Colors.orange.shade100,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            CartEntry cartEntry = list[index];
            List<ProductAttribute> cartProductAttributes =
                new List<ProductAttribute>();
            json.decode(cartEntry.attributes).forEach((v) {
              cartProductAttributes.add(new ProductAttribute.fromJson(v));
            });
            Product product = products[index];
            if (product.productsId == null) {
              return Container();
            } else {
              int discount = _calculateDiscount(
                  product.productsPrice, product.discountPrice);

              double attrsPrice = 0.0;
              cartProductAttributes.forEach((element) {
                attrsPrice += double.parse(element.values[0].price.toString());
              });

              return Card(
                color: Colors.orange.shade50,
                margin: EdgeInsets.all(4),
                child: Row(children: [
                  Container(
                    padding: EdgeInsets.all(4.0),
                    width: 150,
                    height: 150,
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
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.productsName,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 5.0),
                                      //Divider(height: 3.0, color: Colors.white),
                                      if (product.categories.length > 0)
                                        Text(
                                          product.categories[0].categoriesName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black45),
                                        ),
                                    ]),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _productsBloc.cart_products_event_sink
                                      .add(DeleteCartProduct(index));
                                  _box.deleteAt(index);
                                },
                                child: IconTheme(
                                    data: IconThemeData(
                                        color: Colors.orange.shade600),
                                    child: Icon(
                                      Icons.delete_sweep_sharp,
                                      size: 50.0,
                                    )),
                              ),
                            ]),
                            SizedBox(height: 10.0),
                            Row(children: [
                              Expanded(
                                  child: Text(
                                "Precio".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              )),
                              (discount != null && discount != 0)
                                  ? Row(
                                      children: [
                                        Text(
                                          "\$" +
                                              double.parse(product.productsPrice
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black45,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "\$" +
                                              double.parse(product.discountPrice
                                                      .toString())
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange.shade600,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "\$" +
                                          double.parse(product.productsPrice
                                                  .toString())
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ]),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: cartProductAttributes.length,
                              itemBuilder: (context, index) {
                                return Row(children: [
                                  Expanded(
                                      child: Text(
                                    cartProductAttributes[index].option.name,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  )),
                                  Text(
                                    cartProductAttributes[index]
                                        .values[0]
                                        .value,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(cartProductAttributes[index]
                                          .values[0]
                                          .pricePrefix +
                                      "\$" +
                                      double.parse(cartProductAttributes[index]
                                              .values[0]
                                              .price
                                              .toString())
                                          .toStringAsFixed(2)),
                                ]);
                              },
                            ),
                            //Divider(height: 10.0, color: Colors.white),
                            SizedBox(
                              height: 8,
                            ),
                            Row(children: [
                              Expanded(
                                  child: Text(
                                "Cantidad".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              )),
                              GestureDetector(
                                onTap: () {
                                  if (cartEntry.quantity > 1) {
                                    _productsBloc.cart_products_event_sink.add(
                                        DecrementCartProductQuantity(index));
                                    cartEntry.quantity--;
                                    _box.putAt(index, cartEntry);
                                  }
                                },
                                child: IconTheme(
                                    data: IconThemeData(
                                        //color: Theme.of(context).primaryColor),
                                        color: Color.fromRGBO(247, 121, 34, 1)),
                                    child:
                                        Icon(Icons.remove_circle, size: 30.0)),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                product.customerBasketQuantity.toString(),
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  cartEntry.quantity++;
                                  _productsBloc.cart_products_event_sink
                                      .add(IncrementCartProductQuantity(index));
                                  _box.putAt(index, cartEntry);
                                },
                                child: IconTheme(
                                    data: IconThemeData(
                                        color: Color.fromRGBO(247, 121, 34, 1)),
                                    child: Icon(Icons.add_circle, size: 30.0)),
                              ),
                            ]),

                            SizedBox(height: 10.0),
                            Row(children: [
                              Expanded(
                                  child: Text(
                                "Total".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold),
                              )),
                              (discount != null && discount != 0)
                                  ? Row(
                                      children: [
                                        Text(
                                          "\$" +
                                              ((double.parse(product
                                                              .productsPrice
                                                              .toString()) +
                                                          attrsPrice) *
                                                      cartEntry.quantity)
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          "\$" +
                                              ((double.parse(product
                                                              .discountPrice
                                                              .toString()) +
                                                          attrsPrice) *
                                                      cartEntry.quantity)
                                                  .toStringAsFixed(2),
                                          style: TextStyle(
                                              //color: Theme.of(context).primaryColor),
                                              color: Color.fromRGBO(
                                                  247, 121, 34, 1),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "\$" +
                                          ((double.parse(product.productsPrice
                                                          .toString()) +
                                                      attrsPrice) *
                                                  cartEntry.quantity)
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                          //color: Theme.of(context).primaryColor),
                                          color:
                                              Color.fromRGBO(247, 121, 34, 1),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ])
                          ]),
                    ),
                  )
                ]),
              );
            }
          },
        ),
      ),
    );
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
}
