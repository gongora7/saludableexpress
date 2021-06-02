import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/responses/add_address_response.dart';
import 'package:flutter_app1/src/api/responses/countries_response.dart';
import 'package:flutter_app1/src/api/responses/zones_response.dart';
import 'package:flutter_app1/src/blocs/address/address_bloc.dart';
import 'package:flutter_app1/src/models/address/address.dart';
import 'package:flutter_app1/src/models/address/country.dart';
import 'package:flutter_app1/src/models/address/zone.dart';
import 'package:flutter_app1/src/repositories/address_repo.dart';

class AddAddressPage extends StatefulWidget {
  final Function() getAddresses;

  AddAddressPage(this.getAddresses);

  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Agregar dirección"),
        ),
        body: MyCustomForm(widget.getAddresses),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final Function() getAddresses;

  MyCustomForm(this.getAddresses);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  final _addressBloc = AddressBloc(RealAddressRepo());

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();

  Country selectedCountry;
  Zone selectedZone;

  @override
  void initState() {
    super.initState();

    _addressBloc.addressEventSink.add(GetCountries());

    _addressBloc.addAddressStream.listen((AddAddressResponse response) {
      if (response != null) {
        if (response.success == "1") {
          widget.getAddresses();
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'El campo no puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Apellido',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'El campo no puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Dirección',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'El campo no puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  StreamBuilder(
                    stream: _addressBloc.countriesStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData || snapshot.data != null) {
                        CountriesResponse response =
                            snapshot.data as CountriesResponse;
                        if (response.success == "1" &&
                            response.data.length > 0) {
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                isExpanded: true,
                                hint: Text("País"),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                items: response.data.map((e) {
                                  return new DropdownMenuItem(
                                      value: e, child: Text(e.countriesName));
                                }).toList(),
                                onChanged: (value) {
                                  selectedCountry = value as Country;
                                  _addressBloc.addressEventSink.add(
                                      GetZones(selectedCountry.countriesId));
                                },
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          );
                        } else {
                          return _buildLoadingField("Country");
                        }
                      } else {
                        return _buildLoadingField("Country");
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: _addressBloc.zonesStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData || snapshot.data != null) {
                        ZonesResponse response = snapshot.data as ZonesResponse;
                        if (response.success == "1" &&
                            response.data.length > 0) {
                          return Column(
                            children: [
                              DropdownButtonFormField(
                                isExpanded: true,
                                hint: Text("Estado"),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),
                                ),
                                items: response.data.map((e) {
                                  return new DropdownMenuItem(
                                      value: e, child: Text(e.zoneName));
                                }).toList(),
                                onChanged: (value) {
                                  selectedZone = value as Zone;
                                },
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                            ],
                          );
                        } else {
                          return _buildLoadingField("Zone");
                        }
                      } else {
                        return Container();
                      }
                    },
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: InputDecoration(
                      labelText: 'Ciudad',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'El campo no puede estar vacio';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextFormField(
                    controller: _postalCodeController,
                    decoration: InputDecoration(
                      labelText: 'Código Postal',
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.all(8.0),
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'El campo no puede estar vacio';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              color: Colors.blueAccent[400],
              height: 60.0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                if (_formKey.currentState.validate() &&
                    selectedCountry != null &&
                    selectedZone != null) {
                  Address shippingAddress = Address();
                  shippingAddress.deliveryFirstName = _firstNameController.text;
                  shippingAddress.deliveryLastName = _lastNameController.text;
                  shippingAddress.deliveryLocation = "";
                  shippingAddress.deliveryStreetAddress =
                      _addressController.text;
                  shippingAddress.deliveryCity = _cityController.text;
                  shippingAddress.deliveryPostCode = _postalCodeController.text;
                  shippingAddress.deliveryPhone = "";

                  shippingAddress.deliveryZone = selectedZone;
                  shippingAddress.deliveryCountry = selectedCountry;
                  shippingAddress.deliveryCountryCode = "";
                  shippingAddress.deliveryLat = "";
                  shippingAddress.deliveryLong = "";

                  _addressBloc.addAddressEventSink
                      .add(AddAddress(shippingAddress));
                  showLoaderDialog(context);
                }
              },
              child: Text(
                "Proceed",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget _buildLoadingField(String title) {
    return Column(
      children: [
        Stack(
          children: <Widget>[
            TextFormField(
              enabled: false,
              decoration: InputDecoration(
                labelText: title,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(8.0),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(8.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
