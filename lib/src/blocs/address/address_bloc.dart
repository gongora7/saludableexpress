import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_app1/src/api/responses/add_address_response.dart';
import 'package:flutter_app1/src/api/responses/address_response.dart';
import 'package:flutter_app1/src/api/responses/countries_response.dart';
import 'package:flutter_app1/src/api/responses/zones_response.dart';
import 'package:flutter_app1/src/models/address/address.dart';
import 'package:flutter_app1/src/models/address/my_address.dart';
import 'package:flutter_app1/src/repositories/address_repo.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc {
  final AddressRepo addressRepo;

  final _countriesStreamController = StreamController<CountriesResponse>.broadcast();
  final _countriesEventController = StreamController<AddressEvent>();

  final _zonesStreamController = StreamController<ZonesResponse>.broadcast();
  final _zonesEventController = StreamController<AddressEvent>();

  final _addAddressStreamController = StreamController<AddAddressResponse>.broadcast();
  final _addAddressEventController = StreamController<AddressEvent>();

  final _getDefaultAddressStreamController = StreamController<MyAddress>.broadcast();
  final _getDetfaultAddressEventController = StreamController<AddressEvent>();

  StreamSink<CountriesResponse> get countriesSink =>
      _countriesStreamController.sink;

  Stream<CountriesResponse> get countriesStream =>
      _countriesStreamController.stream;

  StreamSink<ZonesResponse> get zonesSink => _zonesStreamController.sink;

  Stream<ZonesResponse> get zonesStream => _zonesStreamController.stream;

  StreamSink<AddAddressResponse> get addAddressSink => _addAddressStreamController.sink;
  Stream<AddAddressResponse> get addAddressStream => _addAddressStreamController.stream;

  StreamSink<MyAddress> get getDetaultAddressSink => _getDefaultAddressStreamController.sink;
  Stream<MyAddress> get getDefaultAddressStream => _getDefaultAddressStreamController.stream;

  Sink<AddressEvent> get addressEventSink => _countriesEventController.sink;

  Sink<AddressEvent> get addAddressEventSink => _addAddressEventController.sink;

  Sink<AddressEvent> get getDefaultAddressEventSink => _getDetfaultAddressEventController.sink;


  AddressBloc(this.addressRepo) {
    _countriesEventController.stream.listen((event) async {
      if (event is GetCountries) {
        CountriesResponse data = await addressRepo.fetchCountries();
        countriesSink.add(data);
      } else if (event is GetZones) {
        zonesSink.add(ZonesResponse.withError("empty"));
        ZonesResponse data = await addressRepo.fetchZones(event.countryId);
        zonesSink.add(data);
      }
    });

    _addAddressEventController.stream.listen((event) async {
      if (event is AddAddress) {
        AddAddressResponse data = await addressRepo.addAddress(event.address);
        addAddressSink.add(data);
      }
    });

    _getDetfaultAddressEventController.stream.listen((event) async {
      if (event is GetDefaultAddress) {
        AddressResponse data = await addressRepo.fetchAllAddresses();
        if(data != null){
          for (int i=0; i<data.data.length; i++){
            if (data.data[i].defaultAddress == 1){
              getDetaultAddressSink.add(data.data[i]);
            }
          }
        } else {
          getDetaultAddressSink.add(null);
        }
      }
    });

  }

  dispose() {
    _countriesStreamController.close();
    _countriesEventController.close();
    _zonesStreamController.close();
    _zonesEventController.close();
    _addAddressStreamController.close();
    _addAddressEventController.close();
    _getDefaultAddressStreamController.close();
    _getDetfaultAddressEventController.close();
  }
}
