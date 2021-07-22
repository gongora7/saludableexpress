import 'package:flutter/material.dart';
import 'package:flutter_app1/src/ui/widgets/AddressTile.dart';

class AddresSearch extends StatefulWidget {
  const AddresSearch({Key key}) : super(key: key);

  @override
  _AddresSearchState createState() => _AddresSearchState();
}

class _AddresSearchState extends State<AddresSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AddressTile(),
          ],
        ),
      ),
    );
  }
}
