import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/ui/screens/tabs/FavoriteTab.dart';
import 'package:flutter_app1/src/ui/screens/tabs/ListenTab.dart';
import 'package:flutter_app1/src/ui/screens/tabs/MeTab.dart';

import '../../../config.dart';

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
      appBar: AppBar(title: Text('Podcast')),
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
