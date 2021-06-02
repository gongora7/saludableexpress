import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/models/categories_response/category.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/ui/pages/category_page.dart';
import 'package:flutter_app1/src/ui/pages/shop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class HomePage5 extends StatefulWidget {
  bool isHeaderVisible = false;
  final Function(Product product) _toProductDetailPage;
  final Function(int categoryId) _toShopFromCategory;

  HomePage5(this.isHeaderVisible, this._toProductDetailPage, this._toShopFromCategory);

  @override
  _HomePage5State createState() => _HomePage5State(isHeaderVisible);
}

class _HomePage5State extends State<HomePage5> {
  var isHeaderVisible;

  _HomePage5State(this.isHeaderVisible);

  @override
  Widget build(BuildContext context) {
    return isHeaderVisible
        ? Scaffold(
            appBar: AppBar(
              title: Text("HomePage5"),
            ),
            body: CategoryPage(2, false, widget._toShopFromCategory),
          )
        : CategoryPage(2, false, widget._toShopFromCategory);
  }
}
