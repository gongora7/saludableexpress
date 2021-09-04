import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../../../config.dart';

class MeTab extends StatefulWidget {
  @override
  _MeTabState createState() => _MeTabState();
}

class _MeTabState extends State<MeTab> {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Divider(),
        ListTile(
          title: Text("Logout"),
          onTap: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, "/login");
          },
          trailing: Icon(Icons.exit_to_app),
        ),
        Divider(),
        ListTile(
          title: Text("About App"),
          onTap: () {
            _launchURL(aboutApp);
          },
          trailing: Icon(Icons.info_outline),
        ),
        Divider(),
        ListTile(
          title: Text("Contact"),
          onTap: () {
            _launchURL("mailto:$contactMail");
          },
          trailing: Icon(Icons.mail_outline),
        ),
        Divider(),
        ListTile(
          title: Text("Rate this App"),
          onTap: () {
            _launchURL(appURL);
          },
          trailing: Icon(Icons.rate_review),
        ),
        Divider(),
      ],
    ));
  }
}
