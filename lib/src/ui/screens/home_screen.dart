import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';
import 'package:flutter_app1/constants.dart';
import 'package:flutter_app1/src/blocs/user/login_bloc.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/ui/pages/about.dart';
import 'package:flutter_app1/src/ui/pages/contact_us.dart';
import 'package:flutter_app1/src/ui/pages/currencies_page.dart';
import 'package:flutter_app1/src/ui/pages/home_page_10.dart';
import 'package:flutter_app1/src/ui/pages/home_page_5.dart';
import 'package:flutter_app1/src/ui/pages/home_page_6.dart';
import 'package:flutter_app1/src/ui/pages/home_page_7.dart';
import 'package:flutter_app1/src/ui/pages/home_page_8.dart';
import 'package:flutter_app1/src/ui/pages/home_page_9.dart';
import 'package:flutter_app1/src/ui/pages/intro.dart';
import 'package:flutter_app1/src/ui/pages/language_page.dart';
import 'package:flutter_app1/src/ui/pages/my_addresses.dart';
import 'package:flutter_app1/src/ui/pages/my_favorites.dart';
import 'package:flutter_app1/src/ui/pages/my_orders.dart';
import 'package:flutter_app1/src/ui/pages/settings.dart';
import 'package:flutter_app1/src/ui/screens/cart_screen.dart';
import 'package:flutter_app1/src/ui/pages/category_page.dart';
import 'package:flutter_app1/src/ui/pages/home_page_3.dart';
import 'package:flutter_app1/src/ui/pages/me.dart';
import 'package:flutter_app1/src/ui/screens/login_page.dart';
import 'package:flutter_app1/src/ui/screens/my_account_screen.dart';
import 'package:flutter_app1/src/ui/pages/news.dart';
import 'package:flutter_app1/src/ui/pages/shop.dart';
import 'package:flutter_app1/src/ui/screens/product_detail_page.dart';
import 'package:flutter_app1/src/ui/screens/search_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:share/share.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import '../../models/drawer_menu_item.dart';
import '../../utils/locale_utils/app_localization.dart';
import '../../utils/theme_utils/app_themes.dart';
import '../pages/home_page_1.dart';
import '../pages/home_page_2.dart';
import '../pages/home_page_4.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
int _page = 0;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  //String navigationStyle = "both";
  String navigationStyle = "side";
  Box _box;
  Box _userBox;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>()
  ];

  @override
  void initState() {
    super.initState();
    _box = Hive.box("my_cartBox");
    _userBox = Hive.box("my_userBox");

    AppData.user = _userBox.get("current_user");

    AppData.data = <DrawerMenuItem>[
      AppConstants.isDemoMode
          ? DrawerMenuItem('Inicio', Icons.home, <DrawerMenuItem>[
              DrawerMenuItem('Home 1', Icons.home),
              DrawerMenuItem('Home 2', Icons.home),
              DrawerMenuItem('Home 3', Icons.home),
              DrawerMenuItem('Home 4', Icons.home),
              DrawerMenuItem('Home 5', Icons.home),
              DrawerMenuItem('Home 6', Icons.home),
              DrawerMenuItem('Home 7', Icons.home),
              DrawerMenuItem('Home 8', Icons.home),
              DrawerMenuItem('Home 9', Icons.home),
              DrawerMenuItem('Home 10', Icons.home),
            ])
          : DrawerMenuItem("Inicio", Icons.home),
      AppConstants.isDemoMode
          ? DrawerMenuItem('Categorías', Icons.card_travel, <DrawerMenuItem>[
              DrawerMenuItem('Category 1', Icons.card_travel),
              DrawerMenuItem('Category 2', Icons.card_travel),
              DrawerMenuItem('Category 3', Icons.card_travel),
              DrawerMenuItem('Category 4', Icons.card_travel),
              DrawerMenuItem('Category 5', Icons.card_travel),
              DrawerMenuItem('Category 6', Icons.card_travel),
            ])
          : DrawerMenuItem("Categorías", Icons.card_travel),
      AppConstants.isDemoMode
          ? DrawerMenuItem('Tienda', Icons.shopping_basket, <DrawerMenuItem>[
              DrawerMenuItem('Newest', Icons.store),
              DrawerMenuItem('Top Sellers', Icons.shopping_basket),
              DrawerMenuItem('Super Deals', Icons.shopping_basket),
              DrawerMenuItem('Most Liked', Icons.shopping_basket),
              DrawerMenuItem('Flash Sale', Icons.shopping_basket),
            ])
          : DrawerMenuItem("Tienda", Icons.shopping_basket),
      //DrawerMenuItem("My Account", Icons.person),
      DrawerMenuItem("Mis Pedidos", Icons.assignment_sharp),
      DrawerMenuItem("Mis Direcciones", Icons.location_city),
      /* DrawerMenuItem("My Favorites", Icons.favorite),

      DrawerMenuItem("Intro", Icons.integration_instructions),
      DrawerMenuItem("News", Icons.web),
      DrawerMenuItem("Contact Us", Icons.message),
      DrawerMenuItem("About", Icons.info),
      DrawerMenuItem("Share App", Icons.share),
      DrawerMenuItem("Rate & Review", Icons.rate_review),
      DrawerMenuItem("Settings", Icons.settings),*/
      DrawerMenuItem(
          (AppData.user != null) ? "Cerrar Sesión" : "Iniciar Sesión",
          Icons.login)
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState.maybePop();

        print(
            'isFirstRouteInCurrentTab: ' + isFirstRouteInCurrentTab.toString());
        // let system handle back button if we're on the first route
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        } else {
          return isFirstRouteInCurrentTab;
        }
      },
      child: ValueListenableBuilder(
        valueListenable: _box.listenable(),
        builder: (context, value, child) {
          AppData.cartIds.clear();
          Map<dynamic, dynamic> raw = value.toMap();
          raw.values.forEach((element) {
            CartEntry cartEntry = element;
            AppData.cartIds.add(cartEntry.id);
          });
          return Scaffold(
            key: scaffoldKey,
            appBar: getAppBar(context),
            body: Stack(
              children: [
                _buildOffstageNavigator(0),
                _buildOffstageNavigator(1),
                _buildOffstageNavigator(2),
                _buildOffstageNavigator(3),
                _buildOffstageNavigator(4),

                //default flex is 2
              ],
            ),
            drawer: (navigationStyle != "side" && navigationStyle != "both")
                ? null
                : buildDrawer(),
            bottomNavigationBar:
                (navigationStyle != "bottom" && navigationStyle != "both")
                    ? null
                    : Theme(
                        data: Theme.of(context).copyWith(
                            canvasColor: Theme.of(context).primaryColor,
                            primaryColor: Colors.white,
                            textTheme: Theme.of(context).textTheme.copyWith(
                                caption: TextStyle(color: Colors.white70))),
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          currentIndex: _selectedIndex,
                          onTap: (value) {
                            _selectCurrentItem(value);
                          },
                          items: [
                            BottomNavigationBarItem(
                              label: "Inicio",
                              icon: Icon(Icons.home_rounded),
                              activeIcon: Icon(Icons.home_outlined),
                            ),
                            BottomNavigationBarItem(
                              label: "Categorías",
                              icon: Icon(Icons.card_travel_outlined),
                              activeIcon: Icon(Icons.card_travel_rounded),
                            ),
                            BottomNavigationBarItem(
                              label: "Tienda",
                              icon: Icon(Icons.shop_outlined),
                              activeIcon: Icon(Icons.shop_rounded),
                            ),
                            /* BottomNavigationBarItem(
                            label: "News",
                            icon: Icon(Icons.library_books),
                          ),
                          BottomNavigationBarItem(
                            label: "Me",
                            icon: Icon(Icons.account_box),
                          ), */
                          ],
                        ),
                      ),
          );
        },
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView.builder(
        padding: const EdgeInsets.all(0.0),
        itemCount: AppData.data.length == 0 ? 1 : AppData.data.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildDrawerHeader(context);
          }
          return _buildTiles(AppData.data[index - 1]);
        },
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    return GestureDetector(
      onTap: () {
//         Navigator.pop(context);
//         if (AppData.user != null)
//           _selectCurrentItem(4);
// /*
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => MyAccount()));
// */
//         else
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => Login()));
      },
      child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Stack(children: [
            DrawerHeader(
              child: Row(
                children: [
                  new Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: new BoxDecoration(shape: BoxShape.circle),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                        imageUrl:
                            "http://store.saludableexpress.com/images/media/2021/06/thumbnail1624495981v19jV23507.png",
                        fit: BoxFit.fill,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          (AppData.user != null)
                              ? "Bienvenido " + AppData.user.firstName != null
                                  ? AppData.user.firstName
                                  : "" + " " + AppData.user.lastName != null
                                      ? AppData.user.lastName
                                      : ""
                              : "Login & Registro",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          (AppData.user != null)
                              ? AppData.user.email != null
                                  ? AppData.user.email
                                  : "" + "\n" + AppData.user.phone != null
                                      ? AppData.user.phone
                                      : ""
                              : "Inicia Sesión ó crea una cuenta",
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            /* SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.language),
                    tooltip: 'Language',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LanguagesPage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_money),
                    tooltip: 'Currency',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrenciesPage()));
                    },
                  ),
                ],
              ),
            ),*/
          ])),
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
          News(false),
          Me(mapSelectedItem),
        ].elementAt(index);
      },
    };
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

  void _selectCurrentItem(int position) {
    setState(() {
      _selectedIndex = position;
    });
  }

  Widget _buildTiles(DrawerMenuItem root) {
    if (root.children.isEmpty) {
      return ListTile(
        leading: Icon(root.iconData, size: 30, color: Colors.orange.shade500),
        title: Text(
          root.title.toUpperCase(),
          style: TextStyle(fontSize: 16),
        ),
        onTap: () {
          Navigator.pop(context);
          mapSelectedItem(root.title);
        },
      );
    }
    return ExpansionTile(
      leading: Icon(root.iconData),
      key: PageStorageKey<DrawerMenuItem>(root),
      title: Text(root.title),
      children: root.children.map<Widget>(_buildTiles).toList(),
    );
  }

  void mapSelectedItem(String title) {
    switch (title) {
      case "Inicio":
        _selectCurrentItem(0);
        break;
      case "Home 1":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage1(true, _toProductDetailPage)));
        break;
      case "Home 2":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage2(true, _toProductDetailPage)));
        break;
      case "Home 3":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage3(true, _toProductDetailPage)));
        break;
      case "Home 4":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage4(true, _toProductDetailPage)));
        break;
      case "Home 5":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage5(
                    true, _toProductDetailPage, _toShopFromCategory)));
        break;
      case "Home 6":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage6(true, _toProductDetailPage)));
        break;
      case "Home 7":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage7(true, _toProductDetailPage)));
        break;
      case "Home 8":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage8(true, _toProductDetailPage)));
        break;
      case "Home 9":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage9(true, _toProductDetailPage)));
        break;
      case "Home 10":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage10(true, _toProductDetailPage)));
        break;
      case "Categorías":
        _selectCurrentItem(1);
        break;
      case "Category 1":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(1, true, _toShopFromCategory)));
        break;
      case "Category 2":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(2, true, _toShopFromCategory)));
        break;
      case "Category 3":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(3, true, _toShopFromCategory)));
        break;
      case "Category 4":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(4, true, _toShopFromCategory)));
        break;
      case "Category 5":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(5, true, _toShopFromCategory)));
        break;
      case "Category 6":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CategoryPage(6, true, _toShopFromCategory)));
        break;
      case "Tienda":
        _selectCurrentItem(2);
        break;
      case "Newest":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Shop(0, "Newest", true, _toProductDetailPage)));
        break;
      case "Top Sellers":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Shop(0, "top seller", true, _toProductDetailPage)));
        break;
      case "Super Deals":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Shop(0, "special", true, _toProductDetailPage)));
        break;
      case "Most Liked":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Shop(0, "most liked", true, _toProductDetailPage)));
        break;
      case "Flash Sale":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Shop(0, "flash sale", true, _toProductDetailPage)));
        break;
      case "News":
        _selectCurrentItem(3);
        break;
      case "Me":
        _selectCurrentItem(4);
        break;
      case "My Account":
        _selectCurrentItem(4);
/*
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAccount()));
*/
        break;
      case "Select Language":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LanguagesPage()));
        break;
      case "Select Currency":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CurrenciesPage()));
        break;
      case "Mis Pedidos":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyOrders()));
        break;
      case "Mis Direcciones":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyAddresses()));
        break;
      case "My Favorites":
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyFavorites(_toProductDetailPage)));
        break;

      case "News":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => News(true)),
        );
        break;
      case "Contact Us":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactUs()));
        break;
      case "Share App":
        Share.share('check out my website https://example.com');
        break;
      case "About":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => About()));
        break;
      case "Settings":
        _selectCurrentItem(4);
        break;
      case "Iniciar Sesión":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
        break;
      case "Cerrar Sesión":
        _selectCurrentItem(0);
        _userBox.delete("current_user");
        AppData.user = null;
        AppData.data.removeLast();
        AppData.data.add(DrawerMenuItem(
            (AppData.user != null) ? "Cerrar Sesión" : "Iniciar Sesión",
            Icons.login_rounded));
        break;
      case "Logout":
        _selectCurrentItem(0);
        _userBox.delete("current_user");
        AppData.user = null;
        AppData.data.removeLast();
        AppData.data.add(DrawerMenuItem(
            (AppData.user != null) ? "Cerrar Sesión" : "Iniciar Sesión",
            Icons.login_rounded));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Se ha cerrado sesión correctamente')));

        break;
/*
      case "ProductDetailsPage":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProductDetailPage()));
        break;
*/
    }
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
      //title: Text(AppLocalizations.of(context).translate('appname')),
      title: Text('Saludable Express'),
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
        ),
      ],
    );
  }
}

SnackBar createSnackBar(String string) {
  return SnackBar(
    content: Text(string),
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: "OK",
      onPressed: () {
        print("Ok clicked");
      },
    ),
  );
}
