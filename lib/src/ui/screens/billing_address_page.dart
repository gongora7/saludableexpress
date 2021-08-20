import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/responses/countries_response.dart';
import 'package:flutter_app1/src/api/responses/zones_response.dart';
import 'package:flutter_app1/src/blocs/address/address_bloc.dart';
import 'package:flutter_app1/src/models/address/address.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/address/country.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/address/zone.dart';
import 'package:flutter_app1/src/repositories/address_repo.dart';
import 'package:flutter_app1/src/ui/screens/shipping_methods_page.dart';

class BillingAddress extends StatelessWidget {
  List<CartEntry> cartEntries;
  List<Product> cartProducts;
  Address shippingAddress;
  double totalPrice;

  BillingAddress({
    this.cartEntries,
    this.cartProducts,
    this.shippingAddress,
    this.totalPrice,
  });

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
          title: Text("Dirección de Facturación"),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            MyCustomForm(
              cartEntries: cartEntries,
              cartProducts: cartProducts,
              shippingAddress: shippingAddress,
              totalPrice: totalPrice,
            ),
          ],
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  List<CartEntry> cartEntries;
  List<Product> cartProducts;
  Address shippingAddress;
  double totalPrice;

  MyCustomForm({
    this.cartEntries,
    this.cartProducts,
    this.shippingAddress,
    this.totalPrice,
  });

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
  final _phoneController = TextEditingController();

  Country selectedCountry;
  Zone selectedZone;

  bool isChecked = true;

  @override
  void initState() {
    super.initState();

    _firstNameController.text = widget.shippingAddress.deliveryFirstName;
    _lastNameController.text = widget.shippingAddress.deliveryLastName;
    _addressController.text = widget.shippingAddress.deliveryStreetAddress;
    _cityController.text = widget.shippingAddress.deliveryCity;
    _postalCodeController.text = widget.shippingAddress.deliveryPostCode;
    _phoneController.text = widget.shippingAddress.deliveryPhone;
    selectedCountry = widget.shippingAddress.deliveryCountry;
    selectedZone = widget.shippingAddress.deliveryZone;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.orange.shade50),
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              new Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                            "http://store.saludableexpress.com/images/media/2021/06/thumbnail1624475805czSYz23302.png",
                          )))),
              SizedBox(height: 16.0),
              Text(
                '¿Dónde facturamos tu pedido?',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Container(
                child: Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          enabled: !isChecked,
                          controller: _firstNameController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(1),
                                child: Icon(Icons.person)),
                            labelText: 'Nombre'.toUpperCase(),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(2.0),
                              borderSide: new BorderSide(
                                color: Colors.black45,
                              ),
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
                          enabled: !isChecked,
                          controller: _lastNameController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(1),
                                child: Icon(Icons.people)),
                            labelText: 'Apellido'.toUpperCase(),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(2.0),
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
                          enabled: !isChecked,
                          controller: _addressController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(1),
                                child: Icon(Icons.location_history)),
                            labelText: 'Dirección'.toUpperCase(),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(2.0),
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
                        isChecked
                            ? Column(
                                children: [
                                  TextFormField(
                                    enabled: false,
                                    initialValue: selectedCountry.countriesName,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.all(1),
                                          child: Icon(Icons.flag)),
                                      labelText: 'País'.toUpperCase(),
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              )
                            : StreamBuilder(
                                stream: _addressBloc.countriesStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData ||
                                      snapshot.data != null) {
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
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0),
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            items: response.data.map((e) {
                                              return new DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e.countriesName));
                                            }).toList(),
                                            onChanged: (value) {
                                              selectedCountry =
                                                  value as Country;
                                              _addressBloc.addressEventSink.add(
                                                  GetZones(selectedCountry
                                                      .countriesId));
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
                        isChecked
                            ? Column(
                                children: [
                                  TextFormField(
                                    enabled: false,
                                    initialValue: selectedZone.zoneName,
                                    decoration: InputDecoration(
                                      prefixIcon: Padding(
                                          padding: EdgeInsets.all(1),
                                          child: Icon(Icons.pin_drop)),
                                      labelText: 'Estado'.toUpperCase(),
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(2.0),
                                        borderSide: new BorderSide(
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                ],
                              )
                            : StreamBuilder(
                                stream: _addressBloc.zonesStream,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData ||
                                      snapshot.data != null) {
                                    ZonesResponse response =
                                        snapshot.data as ZonesResponse;
                                    if (response.success == "1" &&
                                        response.data.length > 0) {
                                      return Column(
                                        children: [
                                          DropdownButtonFormField(
                                            isExpanded: true,
                                            hint: Text("Estado"),
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.all(8.0),
                                              border: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        8.0),
                                                borderSide: new BorderSide(),
                                              ),
                                            ),
                                            items: response.data.map((e) {
                                              return new DropdownMenuItem(
                                                  value: e,
                                                  child: Text(e.zoneName));
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
                          enabled: !isChecked,
                          controller: _cityController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(1),
                                child: Icon(Icons.pin_drop)),
                            labelText: 'Ciudad'.toUpperCase(),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(8.0),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              borderSide: new BorderSide(
                                color: Colors.black45,
                              ),
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
                          enabled: !isChecked,
                          controller: _postalCodeController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(1),
                                child: Icon(Icons.album)),
                            labelText: 'Código Postal'.toUpperCase(),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(2.0),
                              borderSide: new BorderSide(
                                color: Colors.black45,
                              ),
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
                          enabled: !isChecked,
                          controller: _phoneController,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                                padding: EdgeInsets.all(1),
                                child: Icon(Icons.phone)),
                            labelText: 'Teléfono'.toUpperCase(),
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.all(10.0),
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(2.0),
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
                        SwitchListTile(
                          title: Text("Igual que dirección de envío"),
                          contentPadding: EdgeInsets.all(0.0),
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              this.isChecked = value;
                              if (!isChecked) {
                                _firstNameController.clear();
                                _lastNameController.clear();
                                _addressController.clear();
                                _cityController.clear();
                                _postalCodeController.clear();
                                _phoneController.clear();
                                selectedCountry = null;
                                selectedZone = null;
                                _addressBloc.addressEventSink
                                    .add(GetCountries());
                              } else {
                                _firstNameController.text =
                                    widget.shippingAddress.deliveryFirstName;
                                _lastNameController.text =
                                    widget.shippingAddress.deliveryLastName;
                                _addressController.text = widget
                                    .shippingAddress.deliveryStreetAddress;
                                _cityController.text =
                                    widget.shippingAddress.deliveryCity;
                                _postalCodeController.text =
                                    widget.shippingAddress.deliveryPostCode;
                                _phoneController.text =
                                    widget.shippingAddress.deliveryPhone;
                                selectedCountry =
                                    widget.shippingAddress.deliveryCountry;
                                selectedZone =
                                    widget.shippingAddress.deliveryZone;
                              }
                            });
                          },
                          activeColor: Theme.of(context).primaryColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: Color.fromRGBO(20, 137, 54, 1),
                  height: 60.0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    if (_formKey.currentState.validate() &&
                        selectedCountry != null &&
                        selectedZone != null) {
                      Address billingAddress = Address();
                      billingAddress.deliveryFirstName =
                          _firstNameController.text;
                      billingAddress.deliveryLastName =
                          _lastNameController.text;
                      billingAddress.deliveryStreetAddress =
                          _addressController.text;
                      billingAddress.deliveryCity = _cityController.text;
                      billingAddress.deliveryPostCode =
                          _postalCodeController.text;
                      billingAddress.deliveryPhone = _phoneController.text;

                      billingAddress.deliveryZone = selectedZone;
                      billingAddress.deliveryCountry = selectedCountry;
                      billingAddress.deliveryCountryCode = "";
                      billingAddress.deliveryLat = "";
                      billingAddress.deliveryLong = "";

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ShippingMethods(
                            cartEntries: widget.cartEntries,
                            cartProducts: widget.cartProducts,
                            shippingAddress: widget.shippingAddress,
                            billingAddress: billingAddress,
                            totalPrice: widget.totalPrice,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    "Siguiente",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
                contentPadding: EdgeInsets.all(10.0),
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(2.0),
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
