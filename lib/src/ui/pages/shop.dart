import 'package:flutter/material.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/ui/widgets/products_by_categories.dart';

class Shop extends StatelessWidget {
  String productsType;
  final Function(Product product) _toProductDetailPage;
  bool isHeaderVisible;
  int selectedCategoryId = 0;

  Shop(this.selectedCategoryId, this.productsType, this.isHeaderVisible, this._toProductDetailPage);

  @override
  Widget build(BuildContext context) {
    return isHeaderVisible
        ? Scaffold(
          appBar: AppBar(
              title: Text("Catálogo Saludable"),
            ),
            body: buildUI(),
          )
        : buildUI();
  }

  Widget buildUI() => ProductsByCategories(selectedCategoryId, productsType, true, true, false, _toProductDetailPage);
}
