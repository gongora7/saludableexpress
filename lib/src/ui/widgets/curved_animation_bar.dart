import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_app1/src/models/News.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/ui/pages/category_page.dart';
import 'package:flutter_app1/src/ui/pages/home_page_1.dart';
import 'package:flutter_app1/src/ui/pages/home_page_10.dart';
import 'package:flutter_app1/src/ui/pages/home_page_2.dart';
import 'package:flutter_app1/src/ui/pages/home_page_3.dart';
import 'package:flutter_app1/src/ui/pages/home_page_4.dart';
import 'package:flutter_app1/src/ui/pages/home_page_5.dart';
import 'package:flutter_app1/src/ui/pages/home_page_6.dart';
import 'package:flutter_app1/src/ui/pages/home_page_7.dart';
import 'package:flutter_app1/src/ui/pages/home_page_8.dart';
import 'package:flutter_app1/src/ui/pages/home_page_9.dart';
import 'package:flutter_app1/src/ui/pages/me.dart';
import 'package:flutter_app1/src/ui/pages/my_favorites.dart';
import 'package:flutter_app1/src/ui/pages/shop.dart';
import 'package:flutter_app1/src/ui/screens/cart_screen.dart';
import 'package:flutter_app1/src/ui/screens/product_detail_page.dart';
import 'package:flutter_app1/src/ui/screens/search_page.dart';

import '../../../app_data.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.compare_arrows, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectedIndex = _selectedIndex;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Stack(
        children: [
          _buildOffstageNavigator(0),
          _buildOffstageNavigator(1),
          _buildOffstageNavigator(2),
          _buildOffstageNavigator(3),
          _buildOffstageNavigator(4),
        ],
      ),
    );
  }

  void _selectCurrentItem(int position) {
    setState(() {
      _selectedIndex = position;
    });
  }

  Widget _buildOffstageNavigator(int index) {
    var routeBuilders = _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name](context),
          );
        },
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    var defaultHomePage;

    switch (AppData.settings.homeStyle) {
      case "1":
        defaultHomePage = HomePage1(false, _toProductDetailPage);
        break;
      case "2":
        defaultHomePage = HomePage2(false, _toProductDetailPage);
        break;
      case "3":
        defaultHomePage = HomePage3(false, _toProductDetailPage);
        break;
      case "4":
        defaultHomePage = HomePage4(false, _toProductDetailPage);
        break;
      case "5":
        defaultHomePage =
            HomePage5(false, _toProductDetailPage, _toShopFromCategory);
        break;
      case "6":
        defaultHomePage = HomePage6(false, _toProductDetailPage);
        break;
      case "7":
        defaultHomePage = HomePage7(false, _toProductDetailPage);
        break;
      case "8":
        defaultHomePage = HomePage8(false, _toProductDetailPage);
        break;
      case "9":
        defaultHomePage = HomePage9(false, _toProductDetailPage);
        break;
      case "10":
        defaultHomePage = HomePage10(false, _toProductDetailPage);
        break;
    }

    return {
      '/': (context) {
        return [
          defaultHomePage,
          CategoryPage(int.tryParse(AppData.settings.categoryStyle), false,
              _toShopFromCategory),
          Shop(0, "nuevos", false, _toProductDetailPage),
        ].elementAt(index);
      },
    };
  }

  void _toProductDetailPage(Product product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProductDetailPage(product)));
  }

  void _toShopFromCategory(int categoryId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Shop(categoryId, "newest", true, _toProductDetailPage)));
  }

  AppBar getAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromRGBO(90, 0, 132, 1),
      //title: Text(AppLocalizations.of(context).translate('appname')),
      title:
          Text('Easy Store', style: TextStyle(fontFamily: 'Montserrat-bold')),
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
              new Icon(Icons.favorite_border_rounded, size: 30),
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
          tooltip: 'Favoritos',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyFavorites(_toProductDetailPage)));
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
        ),
      ],
    );
  }
}
