
import 'package:flutter/cupertino.dart';

class DrawerMenuItem {
  final String title;
  final IconData iconData;
  final List<DrawerMenuItem> children;

  DrawerMenuItem(this.title, this.iconData, [this.children = const <DrawerMenuItem>[]]);
}
