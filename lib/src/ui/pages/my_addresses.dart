import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app1/src/blocs/my_address/my_address_bloc.dart';
import 'package:flutter_app1/src/models/address/address.dart';
import 'package:flutter_app1/src/models/address/my_address.dart';
import 'package:flutter_app1/src/ui/pages/add_address_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  MyAddressBloc addressBloc;
  MyAddress selected;

  @override
  void initState() {
    super.initState();

    addressBloc = BlocProvider.of<MyAddressBloc>(context);
    addressBloc.add(GetMyAddresses());
  }

  void _getAddresses() {
    addressBloc = BlocProvider.of<MyAddressBloc>(context);
    addressBloc.add(GetMyAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis direcciones"),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.add),
          //   tooltip: 'Add Address',
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => AddAddressPage(_getAddresses)));
          //   },

          // ),
        ],
      ),
      body: BlocBuilder<MyAddressBloc, MyAddressState>(
        builder: (context, state) {
          if (state is MyAddressInitial) {
            return buildLoading();
          } else if (state is MyAddressLoading) {
            return buildLoading();
          } else if (state is MyAddressLoaded) {
            return buildColumnWithData(context, state.addressResponse.data);
          } else if (state is MyAddressError) {
            return buildLoading();
          } else {
            return buildLoading();
          }
        },
      ),
    );
  }

  Widget buildColumnWithData(BuildContext context, List<MyAddress> data) {
    if (data.isNotEmpty) selected = data[0];
    for (int i = 0; i < data.length; i++) {
      if (data[i].defaultAddress == 1) {
        selected = data[i];
      }
    }
    return RadioListBuilder(data, shippingServiceSelected);
/*
    return ListView.builder(
      padding: EdgeInsets.all(4.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildListItem(data[index]);
      },
    );
*/
  }

  void shippingServiceSelected(MyAddress selectedServices) {
    this.selected = selectedServices;
  }

  Widget buildListItem(MyAddress data) {
    return GestureDetector(
      onTap: () {
/*
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => OrderDetailPage(data)));
*/
      },
      child: Card(
        margin: EdgeInsets.all(4.0),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Address # " + data.addressId.toString()),
              SizedBox(
                height: 8.0,
              ),
              Text(
                data.firstname + " " + data.lastname,
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                data.street + ", " + data.city,
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                data.zoneName + ", " + data.countryName,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

class RadioListBuilder extends StatefulWidget {
  final List<MyAddress> shippingServices;
  final Function(MyAddress selectedServices) shippingServiceSelected;

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
          isThreeLine: true,
          value: index,
          groupValue: value,
          onChanged: (ind) => setState(() {
            value = ind;
            widget.shippingServiceSelected(widget.shippingServices[index]);
          }),
          title: Text("Direccion # " +
              widget.shippingServices[index].addressId.toString()),
          subtitle: Text(widget.shippingServices[index].firstname +
              " " +
              widget.shippingServices[index].lastname +
              "\n" +
              widget.shippingServices[index].street +
              ", " +
              widget.shippingServices[index].city +
              "\n" +
              widget.shippingServices[index].zoneName +
              ", " +
              widget.shippingServices[index].countryName),
          secondary: IconButton(
            icon: Icon(Icons.delete),
            tooltip: 'Delete',
            onPressed: () {},
          ),
        );
      },
      itemCount: widget.shippingServices.length,
    );
  }
}
