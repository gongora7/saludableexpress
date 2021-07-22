import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';

class Me extends StatefulWidget {
  final Function(String title) _mapSelectedItem;

  Me(this._mapSelectedItem);

  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  bool isPushNotificationsChecked = true;
  bool isLocalNotificationsChecked = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(32.0),
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                new Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: new BoxDecoration(shape: BoxShape.circle),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png",
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
                  height: 16.0,
                ),
                Text(
                  (AppData.user != null)
                      ? "Bienvenido " + AppData.user.firstName != null
                          ? AppData.user.firstName
                          : "" + " " + AppData.user.lastName != null
                              ? AppData.user.lastName
                              : ""
                      : "Login & Registro",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  (AppData.user != null)
                      ? AppData.user.email != null
                          ? AppData.user.email
                          : "" + "\n" + AppData.user.phone != null
                              ? AppData.user.phone
                              : ""
                      : "Por favor inicia sesión o crea",
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 14.0, color: Colors.black54),
                ),
              ],
            ),
          ),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              /*SwitchListTile(
                title: Text("Local Notifications"),
                value: isLocalNotificationsChecked,
                onChanged: (value) {
                  setState(() {
                    this.isLocalNotificationsChecked = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),
              SwitchListTile(
                title: Text("Push Notifications"),
                value: isPushNotificationsChecked,
                onChanged: (value) {
                  setState(() {
                    this.isPushNotificationsChecked = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),*/

              /* ListTile(
                leading: Icon(Icons.person),
                title: Text("Edit Profile"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Edit Profile");
                },
              ),
              ListTile(
                leading: Icon(Icons.vpn_key),
                title: Text("Change Password"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Change Password");
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text("Select Language"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Select Language");
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_money),
                title: Text("Select Currency"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Select Currency");
                },
              ),
              ListTile(
                leading: Icon(Icons.web),
                title: Text("Official Website"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Official website");
                },
              ),*/
              ListTile(
                leading: Icon(Icons.assignment),
                title: Text("My Orders"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("My Ordersasd");
                },
              ),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text("My Addresses"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("My Addresses");
                  print('widget._mapSelectedItem("My Addresses")');
                },
              ),
              /* ListTile(
                leading: Icon(Icons.favorite),
                title: Text("My Favorites"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("My Favorites");
                },
              ),
              ListTile(
                leading: Icon(Icons.message),
                title: Text("Contact Us"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Contact Us");
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("About"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("About");
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("Share App"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Share App");
                },
              ),
              ListTile(
                leading: Icon(Icons.rate_review),
                title: Text("Rate & Review"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Rate & Review");
                },
              ),*/
              ListTile(
                leading: Icon(Icons.login),
                title: Text((AppData.user != null) ? "Logout" : "Login"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem(
                      (AppData.user != null) ? "Logout" : "Login");
                },
              ),

              /* ListTile(
                leading: Icon(Icons.assignment_return),
                title: Text("Refund Policy"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Refund Policy");
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text("Privacy Policy"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Privacy Policy");
                },
              ),
              ListTile(
                leading: Icon(Icons.alternate_email),
                title: Text("Terms of Service"),
                trailing: Icon(Icons.navigate_next),
                onTap: () {
                  widget._mapSelectedItem("Terms of Service");
                },
              ),*/
            ],
          )
        ],
      ),
    );
  }
}
