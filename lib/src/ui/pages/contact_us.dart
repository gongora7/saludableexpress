import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactUs extends StatefulWidget {
  static const LatLng _center = const LatLng(45.521563, -122.677433);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address"),
                  SizedBox(height: 4,),
                  Text("+123456789"),
                  SizedBox(height: 4,),
                  Text("contact@gmail.com"),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Full Name',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Your Message',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    width: double.maxFinite,
                    child: FlatButton(
                        color: Colors.green[800],
                        onPressed: () {
                        },
                        child: Text(
                          "Send",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}