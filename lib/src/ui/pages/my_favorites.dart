import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/responses/like_product_response.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/ui/widgets/products_widget.dart';

class MyFavorites extends StatefulWidget {
  final Function(Product product) _toProductDetailPage;

  MyFavorites(this._toProductDetailPage);

  @override
  _MyFavoritesState createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Favorites"),
      ),
      body: Products(
          "wishlist", "", false, false, true, widget._toProductDetailPage),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

