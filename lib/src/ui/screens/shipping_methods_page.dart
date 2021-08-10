import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app1/src/api/responses/get_rates_response.dart';
import 'package:flutter_app1/src/blocs/shipping_methods/shipping_methods_bloc.dart';
import 'package:flutter_app1/src/models/address/address.dart';
import 'package:flutter_app1/src/models/cart_entry.dart';
import 'package:flutter_app1/src/models/product_models/product.dart';
import 'package:flutter_app1/src/models/shipping_methods/get_rates_post_model.dart';
import 'package:flutter_app1/src/models/shipping_methods/get_rates_post_product.dart';
import 'package:flutter_app1/src/models/shipping_methods/shipping_service.dart';
import 'package:flutter_app1/src/ui/screens/checkout_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingMethods extends StatefulWidget {
  List<CartEntry> cartEntries;
  List<Product> cartProducts;
  Address shippingAddress;
  Address billingAddress;
  double totalPrice;

  ShippingMethods({
    this.cartEntries,
    this.cartProducts,
    this.shippingAddress,
    this.billingAddress,
    this.totalPrice,
  });

  @override
  _ShippingMethodsState createState() => _ShippingMethodsState();
}

class _ShippingMethodsState extends State<ShippingMethods> {
  String shippingTax = "";

  ShippingService selectedService;

  @override
  void initState() {
    super.initState();

    // ignore: close_sinks
    final shippingMethodsBloc = BlocProvider.of<ShippingMethodsBloc>(context);
    GetRatesPost getRatesPost = GetRatesPost();
    getRatesPost.title = widget.shippingAddress.deliveryFirstName;
    getRatesPost.streetAddress = widget.shippingAddress.deliveryStreetAddress;
    getRatesPost.city = widget.shippingAddress.deliveryCity;
    getRatesPost.state = widget.shippingAddress.deliveryZone.zoneName;
    getRatesPost.postcode = widget.shippingAddress.deliveryPostCode;
    getRatesPost.zone = widget.shippingAddress.deliveryZone.zoneName;
    getRatesPost.taxZoneId =
        widget.shippingAddress.deliveryZone.zoneId.toString();
    getRatesPost.country = widget.shippingAddress.deliveryCountry.countriesName;
    getRatesPost.countryId =
        widget.shippingAddress.deliveryCountry.countriesId.toString();
    getRatesPost.telephone = widget.shippingAddress.deliveryPhone;

    getRatesPost.productsWeight = 0;
    getRatesPost.productsWeightUnit = "g";
    getRatesPost.languageId = "1";
    getRatesPost.currencyCode = "MXN";

    List<GetRatesPostProduct> productPost = List<GetRatesPostProduct>();
    for (int i = 0; i < widget.cartEntries.length; i++) {
      CartEntry tempCartEntry = widget.cartEntries[i];
      Product tempProduct = widget.cartProducts[i];
      GetRatesPostProduct tempProductPost = GetRatesPostProduct();

      tempProductPost.productId = tempCartEntry.id;
      tempProductPost.customerBasketQuantity = tempCartEntry.quantity;
      tempProductPost.finalPrice = tempProduct.productsPrice;
      tempProductPost.price = tempProduct.productsPrice;
      tempProductPost.total = tempProduct.productsPrice;
      tempProductPost.unit = tempProduct.productsWeightUnit;
      tempProductPost.weight = tempProduct.productsWeight;

      getRatesPost.productsWeight += double.parse(tempProduct.productsWeight);

      productPost.add(tempProductPost);
    }

    getRatesPost.products = productPost;

    shippingMethodsBloc.add(GetShippingMethods(getRatesPost));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Métodos de Envío"),
      ),
      body: BlocBuilder<ShippingMethodsBloc, ShippingMethodsState>(
        builder: (context, state) {
          if (state is ShippingMethodsInitial) {
            return buildLoading();
          } else if (state is ShippingMethodsLoading) {
            return buildLoading();
          } else if (state is ShippingMethodsLoaded) {
            return buildBody(
                context, readServices(state.shippingMethodsResponse));
          } else if (state is ShippingMethodsError) {
            return buildLoading();
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }

  Widget buildBody(
      BuildContext context, List<ShippingService> shippingServices) {
    if (shippingServices.isNotEmpty) {
      selectedService = shippingServices[0];
      return Stack(
        fit: StackFit.expand,
        children: [
          RadioListBuilder(shippingServices, shippingServiceSelected),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: FlatButton(
              color: Colors.green[500],
              height: 70.0,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Checkout(
                      cartEntries: widget.cartEntries,
                      cartProducts: widget.cartProducts,
                      shippingAddress: widget.shippingAddress,
                      billingAddress: widget.billingAddress,
                      shippingTax: shippingTax,
                      shippingService: selectedService,
                      totalPrice: widget.totalPrice,
                    ),
                  ),
                );
              },
              child: Text(
                "Ir al Pago",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          )
        ],
      );
    } else
      return buildLoading();
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  List<ShippingService> readServices(GetRatesResponse shippingMethodsResponse) {
    List<ShippingService> services = List<ShippingService>();

    shippingTax = shippingMethodsResponse.data.tax;

    if (shippingMethodsResponse.success == "1") {
      if (shippingMethodsResponse.data.shippingMethods.freeShipping != null &&
          shippingMethodsResponse.data.shippingMethods.freeShipping.success ==
              "1")
        services.add(shippingMethodsResponse
            .data.shippingMethods.freeShipping.services.first);

      if (shippingMethodsResponse.data.shippingMethods.localPickup != null &&
          shippingMethodsResponse.data.shippingMethods.localPickup.success ==
              "1")
        services.add(shippingMethodsResponse
            .data.shippingMethods.localPickup.services.first);

      if (shippingMethodsResponse.data.shippingMethods.flateRate != null &&
          shippingMethodsResponse.data.shippingMethods.flateRate.success == "1")
        services.add(shippingMethodsResponse
            .data.shippingMethods.flateRate.services.first);

      if (shippingMethodsResponse.data.shippingMethods.shippingPrice != null &&
          shippingMethodsResponse.data.shippingMethods.shippingPrice.success ==
              "1")
        services.add(shippingMethodsResponse
            .data.shippingMethods.shippingPrice.services.first);
    }

    return services;
  }

  void shippingServiceSelected(ShippingService selectedServices) {
    this.selectedService = selectedServices;
  }
}

class RadioListBuilder extends StatefulWidget {
  final List<ShippingService> shippingServices;
  final Function(ShippingService selectedServices) shippingServiceSelected;

  const RadioListBuilder(this.shippingServices, this.shippingServiceSelected);

  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return RadioListTile(
          value: index,
          groupValue: value,
          onChanged: (ind) => setState(() {
            value = ind;
            widget.shippingServiceSelected(widget.shippingServices[index]);
          }),
          title: Text(
            widget.shippingServices[index].name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            widget.shippingServices[index].shippingMethod,
            style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
          ),
          secondary: Text(
            "\$" +
                double.parse(widget.shippingServices[index].rate.toString())
                    .toStringAsFixed(2),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        );
      },
      itemCount: widget.shippingServices.length,
    );
  }
}
