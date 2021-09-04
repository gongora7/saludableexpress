import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/repositories/categories_repo.dart';

import 'products_widget.dart';

class ProductsByType extends StatefulWidget {
  final Function(Product product) _toProductDetailPage;

  ProductsByType(this._toProductDetailPage);

  @override
  _ProductsByTypeState createState() =>
      _ProductsByTypeState(_toProductDetailPage);
}

class _ProductsByTypeState extends State<ProductsByType>
    with TickerProviderStateMixin {
  final Function(Product product) _toProductDetailPage;

  _ProductsByTypeState(this._toProductDetailPage);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        children: [
          TabBar(
              unselectedLabelColor: Colors.lightGreen[100],
              labelColor: Colors.green[600],
              indicatorWeight: 2,
              indicatorColor: Colors.green[600],
              tabs: [
                Tab(
                  child: (Text(
                    "Nuevos Productos".toUpperCase(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                ),

                /*Tab(
              text: "Top Seller",
            ),*/

                /* Tab(
              text: "Most Liked",
            ),*/
              ]),
          Container(
            height: 250,
            child: TabBarView(children: [
/*
              Center(child: Text("Top Sellers")),
              Center(child: Text("Super Deals")),
              Center(child: Text("Most Liked")),
*/
              Container(
                  child: Products(
                      "special", "", true, false, false, _toProductDetailPage)),
              /*Products("top seller", "", true, false, false, _toProductDetailPage),*/

              /* Products("most liked", "", true, false, false, _toProductDetailPage),*/
            ]),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
