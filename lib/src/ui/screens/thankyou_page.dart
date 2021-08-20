import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app1/app_data.dart';

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
                    data: IconThemeData(color: Colors.blueAccent[400]),
                    child: Icon(
                      Icons.check_circle,
                      size: 100.0,
                    )),
              ),
              Text(
                "Gracias",
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("Gracias por Comprar con Nosotros!"),
              SizedBox(
                height: 30.0,
              ),
              AppData.transferBankData != null
                  ? Column(
                      children: [
                        Text(AppData.transferBankData.publicKey),
                        Text(AppData.transferBankData.clientId),
                        Text(AppData.transferBankData.clientSecret),
                      ],
                    )
                  : Container(),
              FlatButton(
                color: Color.fromRGBO(20, 137, 54, 1),
                height: 80.0,
                child: Text(
                  "CONTINUA COMPRANDO",
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
