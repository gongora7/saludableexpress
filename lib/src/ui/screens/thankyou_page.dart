import 'dart:ui';

import 'package:flutter/material.dart';

class ThankYou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        popBackStackToHome(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orden Confirmada"),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: IconTheme(
                    data: IconThemeData(color: Color.fromRGBO(224, 49, 51, 1)),
                    child: Icon(
                      Icons.check_circle,
                      size: 100.0,
                    )),
              ),
              Text(
                "¡Gracias!".toUpperCase(),
                style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text("Gracias por Comprar con Nosotros!",
                  style:
                      TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50.0,
              ),
              FlatButton(
                color: Color.fromRGBO(90, 0, 132, 1),
                height: 60.0,
                child: Text(
                  "Regresar a Tienda",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  popBackStackToHome(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void popBackStackToHome(BuildContext context) {
    int count = 0;
    Navigator.popUntil(context, (route) {
      return count++ == 6;
    });
  }
}
