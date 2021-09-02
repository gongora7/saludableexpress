import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  //GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  List<GlobalKey<CurvedNavigationBarState>> _bottomNavigationKey = [
    GlobalKey<CurvedNavigationBarState>(),
    GlobalKey<CurvedNavigationBarState>(),
    GlobalKey<CurvedNavigationBarState>(),
  ];
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CurvedNavigationBar(
        key: _bottomNavigationKey[0],
        index: _page,
        height: 60.0,
        items: <Widget>[
          Icon(Icons.home_outlined, size: 30),
          Icon(Icons.category_outlined, size: 30),
          Icon(Icons.storefront, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _selectCurrentItem(_page);
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }

  void _selectCurrentItem(int position) {
    setState(() {
      _page = position;
    });
  }
}
