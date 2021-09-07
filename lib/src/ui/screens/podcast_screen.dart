import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/ui/pages/my_favorites.dart';
import 'package:flutter_app1/src/ui/screens/product_detail_page.dart';
import 'package:flutter_app1/src/ui/screens/search_page.dart';
import 'package:flutter_app1/src/ui/screens/tabs/FavoriteTab.dart';
import 'package:flutter_app1/src/ui/screens/tabs/ListenTab.dart';
import 'package:flutter_app1/src/ui/screens/tabs/MeTab.dart';

import '../../../app_data.dart';
import '../../../config.dart';
import 'cart_screen.dart';

class Podcast extends StatefulWidget {
  Podcast({Key key}) : super(key: key);

  @override
  _PodcastState createState() => _PodcastState();
}

class _PodcastState extends State<Podcast> {
  int _currentIndex = 0;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  var tabs = [ListenTab(), FavoriteTab()];

  @override
  void initState() {
    if (Platform.isIOS) {
      askNotificationPermission();
    }

    super.initState();
  }

  void askNotificationPermission() async {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      sound: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.headset), label: "ESCUCHA"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "FAVORITOS"),
          /*BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "ME"),*/
        ],
      ),
    );
  }
}

AppBar getAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Color.fromRGBO(255, 88, 56, 1),
    //title: Text(AppLocalizations.of(context).translate('appname')),
    title: Text('enelviaje.mx', style: TextStyle(fontFamily: 'Poppins-bold')),

    actions: <Widget>[
      IconButton(
        icon: new Stack(
          children: <Widget>[
            new Icon(Icons.mic_none_rounded, size: 30),
            new Positioned(
              right: 0,
              child: new Container(
                padding: EdgeInsets.all(2),
                /*decoration: new BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8),
                  ),*/
                constraints: BoxConstraints(
                  minWidth: 14,
                  minHeight: 14,
                ),
                /* child: new Text(
                    AppData.cartIds.length.toString(),
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),*/
              ),
            )
          ],
        ),
        tooltip: 'Podcast',
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Podcast()));
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
