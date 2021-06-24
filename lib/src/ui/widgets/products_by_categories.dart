import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/api_provider.dart';
import 'package:flutter_app1/src/api/responses/categories_response.dart';
import 'package:flutter_app1/src/blocs/categories/categories_bloc.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/repositories/categories_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'products_widget.dart';

// ignore: must_be_immutable
class ProductsByCategories extends StatefulWidget {
  final Function(Product product) _toProductDetailPage;
  bool isBottomBarVisible = false;
  bool isNextPageAutoLoad = false;
  bool isTabHasIcon = false;
  String productsType;
  int selectedCategoryId = 0;

  ProductsByCategories(
      this.selectedCategoryId,
      this.productsType,
      this.isBottomBarVisible,
      this.isNextPageAutoLoad,
      this.isTabHasIcon,
      this._toProductDetailPage);

  @override
  _ProductsByCategoriesState createState() =>
      _ProductsByCategoriesState(_toProductDetailPage);
}

class _ProductsByCategoriesState extends State<ProductsByCategories>
    with TickerProviderStateMixin {
  TabController _cardController;

  final Function(Product product) _toProductDetailPage;
  TabPageSelector _tabPageSelector;

  _ProductsByCategoriesState(this._toProductDetailPage);

  @override
  void initState() {
    super.initState();
    //_categoriesBloc.categories_event_sink.add(GetCategories());

    // ignore: close_sinks
    final categoryBloc = BlocProvider.of<CategoriesBloc>(context);
    categoryBloc.add(GetCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesInitial) {
          return buildLoading();
        } else if (state is CategoriesLoading) {
          return buildLoading();
        } else if (state is CategoriesLoaded) {
          _cardController = new TabController(
              vsync: this,
              length: state.categoriesResponse.categoriesData.length + 1);
          _tabPageSelector = new TabPageSelector(controller: _cardController);

          if (widget.selectedCategoryId != 0) {
            for (int i = 0;
                i < state.categoriesResponse.categoriesData.length;
                i++) {
              if (widget.selectedCategoryId ==
                  state.categoriesResponse.categoriesData[i].categoriesId) {
                _cardController.animateTo(i + 1);
                break;
              }
            }
          }

          return buildColumnWithData(context, state.categoriesResponse);
        } else if (state is CategoriesError) {
          return buildLoading();
        } else {
          return buildLoading();
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //_categoriesBloc.dispose();
  }

  Widget buildColumnWithData(BuildContext context, CategoriesResponse data) {
    return DefaultTabController(
      length: data.categoriesData.length + 1,
      //INICIA COLUMNA
      child: Container(
        //color: Colors.amber.shade50,
        child: Column(
          children: [
            TabBar(
                labelColor: Colors.orange[50],
                labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                labelPadding: EdgeInsets.symmetric(horizontal: 20.0),
                unselectedLabelColor: Colors.orange[200],
                indicatorWeight: 3,
                indicatorColor: Colors.orange[400],
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        /* topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)*/),
                    color: Colors.orange.shade300),

                controller: _cardController,
                isScrollable: true,
                tabs: List.generate(
                  data.categoriesData.length + 1,
                  (index) => Tab(
                      icon: (widget.isTabHasIcon)
                          ? index == 0
                              ? Icon(Icons.list)
                              : Container(
                                  width: 45.0,
                                  height: 45.0,
                                  padding: EdgeInsets.all(4.0),
                                  child: CachedNetworkImage(
                                    imageUrl: ApiProvider.imageBaseUrl +
                                        data.categoriesData[index - 1].icon,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            CircularProgressIndicator(
                                                value: downloadProgress.progress),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                )
                          : null,
                      text: index == 0
                          ? "Todo".toUpperCase()
                          : data.categoriesData[index - 1].categoriesName.toUpperCase()),
                )),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: TabBarView(
                    controller: _cardController,
                    children:
                        List.generate(data.categoriesData.length + 1, (index) {
                      if (index == 0) {
                        return Products(
                            widget.productsType,
                            "",
                            false,
                            widget.isBottomBarVisible,
                            widget.isNextPageAutoLoad,
                            _toProductDetailPage);
                      } else {
                        return Products(
                            "Nuevos",
                            data.categoriesData[index - 1].categoriesId.toString(),
                            false,
                            widget.isBottomBarVisible,
                            widget.isNextPageAutoLoad,
                            _toProductDetailPage);
                      }
                    })),
              ),
            ),
          ],
        ),
      ),


      //Termina Columna
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
