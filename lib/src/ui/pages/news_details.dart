import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  final idNews;

  const NewsDetails({Key key, @required this.idNews}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Container(
          child: Text('Hello World' + "$idNews"),
        ),
      ),
    );
  }
}
